//
//  SignInViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/11/24.
//

import Combine

enum SignInAlert {
    case isEmpty
    case isFailed
}

protocol SignInViewModel: ObservableObject {
    var isSignInProgress: Bool { get set }
    var isSignInSuccess: Bool? { get set }
    var showSignInAlert: Bool { get set }
    var alertType: SignInAlert? { get set }
    
    func executeSignIn(id: String, password: String)
}

final class DefaultSignInViewModel {
    @Published var isSignInProgress: Bool = false
    @Published var isSignInSuccess: Bool?
    @Published var showSignInAlert: Bool = false
    @Published var alertType: SignInAlert?
    
    private let usecase: SignInUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: SignInUseCase) {
        self.usecase = usecase
    }
}

extension DefaultSignInViewModel: SignInViewModel {
    func executeSignIn(id: String, password: String) {
        guard !id.isEmpty || !password.isEmpty else {
            showSignInAlert = true
            alertType = .isEmpty
            
            return
        }
        
        isSignInProgress = true
        let data = ["loginId": id, "loginPassword": password]
        
        usecase.executeForSignIn(data: data)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully signed in")
                case .failure(let error):
                    print("DefaultSignInViewModel.executeSignIn(id:password:): ", error)
                }
            }, receiveValue: { [weak self] in
                self?.isSignInProgress = false
                self?.isSignInSuccess = $0.result
                
                //When sign in is failed
                if self?.isSignInSuccess == false {
                    self?.alertType = .isFailed
                    self?.showSignInAlert = true
                }
            })
            .store(in: &cancellables)
    }
}
