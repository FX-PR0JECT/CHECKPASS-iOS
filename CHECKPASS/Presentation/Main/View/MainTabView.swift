//
//  MainView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/16/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Text("Hello World!")
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainTabView()
}
