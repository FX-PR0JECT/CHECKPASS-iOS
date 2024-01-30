//
//  WebView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/29/24.
//

import WebKit
import Combine
import SwiftUI

struct WebView: UIViewRepresentable {
    @EnvironmentObject var viewModel: WebViewModel
    
    private let request: String
    private let webView = WKWebView()
    
    init(_ request: String) {
        self.request = request
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        guard let url = URL(string: request) else {
            return webView
        }
        
        webView.navigationDelegate = context.coordinator    //Delegate webview method
        webView.allowsBackForwardNavigationGestures = true    //Go back using swipe gestures
        webView.load(URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad))
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        private var parent: WebView
        private var observer: NSKeyValueObservation?
        private var cancellables = Set<AnyCancellable>()
        
        init(_ parent: WebView) {
            self.parent = parent
            super.init()
            
            observer = parent.webView.observe(\.estimatedProgress) { [weak self] (webView, _) in
                DispatchQueue.main.async {
                    self?.parent.viewModel.progress = webView.estimatedProgress
                }
            }
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.viewModel.webViewNavigationPublisher.receive(on: RunLoop.main)
                .sink(receiveValue: { receivedValue in
                    switch receivedValue {
                    case .backward:
                        if webView.canGoBack {
                            webView.goBack()
                        }
                    case .forward:
                        if webView.canGoForward {
                            webView.goForward()
                        }
                    }
                })
                .store(in: &cancellables)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            //function called when page load finished
            parent.viewModel.showProgressbar.send(false)
            parent.viewModel.goBackButtonActivation.send(webView.canGoBack)
            parent.viewModel.goForwardButtonActivation.send(webView.canGoForward)
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            parent.viewModel.showProgressbar.send(false)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.viewModel.showProgressbar.send(false)
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.viewModel.showProgressbar.send(true)
        }
    }
}
