//
//  WebViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/30/24.
//

import Combine

enum WebViewNavigation {
    case backward, forward
}

final class WebViewModel: ObservableObject {
    @Published var progress: Double = 0
    @Published var goBackActivation: Bool = false
    @Published var goForwardActivation: Bool = false
    
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
    var showProgressbar = PassthroughSubject<Bool, Never>()
    var goBackButtonActivation = PassthroughSubject<Bool, Never>()
    var goForwardButtonActivation = PassthroughSubject<Bool, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeGoBackButtonActivationPublisher()
        subscribeGoForwardButtonActivationPublisher()
    }
    
    private func subscribeGoBackButtonActivationPublisher() {
        goBackButtonActivation.sink(receiveValue: { [weak self] in
            self?.goBackActivation = $0
        })
        .store(in: &cancellables)
    }
    
    private func subscribeGoForwardButtonActivationPublisher() {
        goForwardButtonActivation.sink(receiveValue: { [weak self] in
            self?.goForwardActivation = $0
        })
        .store(in: &cancellables)
    }
}
