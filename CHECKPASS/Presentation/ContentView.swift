//
//  ContentView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/21/23.
//

import SwiftUI

struct ContentView<KVM: KeyboardVM>: View {
    @StateObject var keyboardViewModel: KVM
    @State private var isNextViewPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            if isNextViewPresented {
                SignInView<KVM>()
                    .environmentObject(keyboardViewModel)
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
    ContentView(keyboardViewModel: KeyboardViewModel())
}
