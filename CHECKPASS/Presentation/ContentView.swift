//
//  ContentView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/21/23.
//

import SwiftUI
import Foundation

struct ContentView<KVM: KeyboardVM, SVM: SignInViewModel>: View {
    @StateObject private var keyboardViewModel: KVM
    @StateObject private var signInViewModel: SVM
    @State private var isNextViewPresented: Bool = false
    
    init(keyboardViewModel: KVM, signInViewModel: SVM) {
        _keyboardViewModel = StateObject(wrappedValue: keyboardViewModel)
        _signInViewModel = StateObject(wrappedValue: signInViewModel)
    }
    
    var body: some View {
        switch signInViewModel.screenType {
        case .signIn:
            SignInView<KVM, SVM>()
                .environmentObject(keyboardViewModel)
                .environmentObject(signInViewModel)
        case .main:
            MainTabView()
        default:
            LaunchScreenView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2, execute: {
                        withAnimation {
                            if let id = UserDefaults.standard.string(forKey: "id"),
                               let pw = UserDefaults.standard.string(forKey: "pw") {
                                signInViewModel.executeSignIn(id: id, password: pw)
                            } else {
                                signInViewModel.screenType = .signIn
                            }
                        }
                    })
                }
        }
    }
}

#Preview {
    ContentView<KeyboardViewModel, DefaultSignInViewModel>(keyboardViewModel: KeyboardViewModel(), signInViewModel: AppDI.shared().getSignInViewModel())
}
