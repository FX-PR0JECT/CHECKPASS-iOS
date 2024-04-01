//
//  DefaultAuthViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/11/24.
//

import SwiftUI
import Combine
import Foundation

enum SignInAlert {
    case isEmpty
    case isFailed
}

enum ScreenType {
    case main
    case launchScreen
    case signIn
}

protocol AuthVM: ObservableObject {
    var isSignInProgress: Bool { get set }
    var showSignInAlert: Bool { get set }
    var alertType: SignInAlert? { get set }
    var screenType: ScreenType { get set }
    
    func executeSignIn(id: String, password: String)
    func executeLogout()
}

final class AuthViewModel {
    @Published var isSignInProgress: Bool = false
    @Published var showSignInAlert: Bool = false
    @Published var alertType: SignInAlert?
    @Published var screenType: ScreenType = .launchScreen
    
    private let signInUseCase: SignInUseCase
    private let logoutUseCase: LogoutUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(signInUseCase: SignInUseCase, logoutUseCase: LogoutUseCase) {
        self.signInUseCase = signInUseCase
        self.logoutUseCase = logoutUseCase
    }
}

extension AuthViewModel: AuthVM {
    func executeSignIn(id: String, password: String) {
        guard !id.isEmpty && !password.isEmpty else {
            showSignInAlert = true
            alertType = .isEmpty
            
            return
        }
        
        isSignInProgress = true
        let data = ["loginId": id, "loginPassword": password]
        
        signInUseCase.executeForSignIn(data: data)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully completed sign in attempt")
                case .failure(let error):
                    print("DefaultSignInViewModel.executeSignIn(id:password:): ", error)
                }
            }, receiveValue: { [weak self] in
                self?.isSignInProgress = false
                
                if !($0.result) {
                    //When sign in is failed
                    self?.alertType = .isFailed
                    self?.showSignInAlert = true
                    print("sign in failed")
                } else {
                    //When sign in is success
                    //Store id and password in the UserDefault
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.set(password, forKey: "pw")
                    print("sign in success")
                    
                    withAnimation {
                        self?.screenType = .main    //Change View
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    func executeLogout() {
        logoutUseCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully finished logout")
                case .failure(let error):
                    print("executeLogout(): Error: " , error)
                }
            }, receiveValue: { [weak self] in
                if $0.result {
                    withAnimation {
                        self?.screenType = .signIn
                    }
                }
            })
            .store(in: &cancellables)
    }
}
