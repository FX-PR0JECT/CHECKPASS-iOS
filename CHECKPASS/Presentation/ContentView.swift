//
//  ContentView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/21/23.
//

import SwiftUI
import Foundation

struct ContentView<KVM: KeyboardVM, AVM: AuthVM>: View {
    @StateObject private var keyboardViewModel: KVM
    @StateObject private var authViewModel: AVM
    @State private var isNextViewPresented: Bool = false
    
    init(keyboardViewModel: KVM, authViewModel: AVM) {
        _keyboardViewModel = StateObject(wrappedValue: keyboardViewModel)
        _authViewModel = StateObject(wrappedValue: authViewModel)
    }
    
    var body: some View {
        switch authViewModel.screenType {
        case .signIn:
            SignInView<KVM, AVM>()
                .environmentObject(keyboardViewModel)
                .environmentObject(authViewModel)
        case .main:
            MainTabView<AVM, _>(viewModel: AppDI.shared().getUserInfoViewModel())
                .environmentObject(authViewModel)
        default:
            LaunchScreenView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2, execute: {
                        withAnimation {
                            if let id = UserDefaults.standard.string(forKey: "id"),
                               let pw = UserDefaults.standard.string(forKey: "pw") {
                                authViewModel.executeSignIn(id: id, password: pw)
                            } else {
                                authViewModel.screenType = .signIn
                            }
                        }
                    })
                }
        }
    }
}

#Preview {
    ContentView<KeyboardViewModel, AuthViewModel>(keyboardViewModel: KeyboardViewModel(), authViewModel: AppDI.shared().getAuthViewModel())
}
