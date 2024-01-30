//
//  WebBrowserView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/29/24.
//

import SwiftUI

struct WebBrowserView: View {
    @ObservedObject private var webViewModel: WebViewModel = WebViewModel()
    @Binding private var showWebPage: Bool
    @State private var showProgressBar: Bool = false
    
    private let request: String
    
    init(_ request: String, showWebPage: Binding<Bool>) {
        self.request = request
        _showWebPage = showWebPage
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if showProgressBar {
                ProgressView(value: webViewModel.progress, total: 1)
            } else {
                ProgressView(value: 0)
            }
            
            WebView(request)
                .environmentObject(webViewModel)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Button(action: {
                                self.webViewModel.webViewNavigationPublisher.send(.backward)
                            }, label: {
                                Image(systemName: "arrow.backward")
                            })
                            .disabled(!webViewModel.goBackActivation)
                            
                            Button(action: {
                                self.webViewModel.webViewNavigationPublisher.send(.forward)
                            }, label: {
                                Image(systemName: "arrow.forward")
                            })
                            .disabled(!webViewModel.goForwardActivation)
                            
                            Spacer()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            showWebPage.toggle()
                        }, label: {
                            Text("취소")
                        })
                    }
                }
                .environmentObject(webViewModel)
        }
        .navigationBarBackButtonHidden()
        .onReceive(webViewModel.showProgressbar) {
            showProgressBar = $0
        }
        .onAppear {
            webViewModel.goBackActivation = false
            webViewModel.goForwardActivation = false
        }
    }
}

#Preview {
    WebBrowserView("https://www.ut.ac.kr/kor.do", showWebPage: .constant(true))
}
