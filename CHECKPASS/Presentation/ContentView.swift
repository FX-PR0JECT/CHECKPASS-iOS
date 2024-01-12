//
//  ContentView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/21/23.
//

import SwiftUI

struct ContentView<KVM: KeyboardVM, SVM: SignInViewModel>: View {
    @StateObject private var keyboardViewModel: KVM
    @StateObject private var signInViewModel: SVM
    @State private var isNextViewPresented: Bool = false
    
    init(keyboardViewModel: KVM, signInViewModel: SVM) {
        _keyboardViewModel = StateObject(wrappedValue: keyboardViewModel)
        _signInViewModel = StateObject(wrappedValue: signInViewModel)
    }
    
    var body: some View {
        NavigationStack {
            if isNextViewPresented {
                SignInView<KVM, SVM>()
                    .environmentObject(keyboardViewModel)
                    .environmentObject(signInViewModel)
            } else {
                LaunchScreenView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2, execute: {
                withAnimation {
                    isNextViewPresented.toggle()
                }
            })
        }
    }
}

#Preview {
    ContentView<KeyboardViewModel, DefaultSignInViewModel>(keyboardViewModel: KeyboardViewModel(), signInViewModel: AppDI.shared().getSignInViewModel())
}
