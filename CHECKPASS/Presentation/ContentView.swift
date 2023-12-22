//
//  ContentView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/21/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isNextViewPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            if isNextViewPresented {
                EmptyView()    //SignInView OR MainView
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
    ContentView()
}
