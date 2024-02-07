//
//  MainView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/16/24.
//

import SwiftUI

struct MainTabView<AVM: AuthVM, UVM: UserInfoVM>: View {
    @StateObject private var userInfoViewModel: UVM
    @EnvironmentObject private var authViewModel: AVM
    
    init(viewModel: UVM) {
        _userInfoViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        TabView() {
            MainView<UVM>()
                .environmentObject(userInfoViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    
                    Text("홈")
                }
            
            MyLectureList()
                .tabItem {
                    Image(systemName: "graduationcap.fill")
                    
                    Text("내 강의")
                }
            
            BoardView()
                .tabItem {
                    Image(systemName: "ellipsis.message")
                    
                    Text("게시판")
                }
            
            SeeMoreView<AVM, UVM>()
                .environmentObject(authViewModel)
                .environmentObject(userInfoViewModel)
                .tabItem {
                    Image(systemName: "ellipsis")
                    
                    Text("더보기")
                }
        }
    }
}

#Preview {
    MainTabView<AuthViewModel, UserInfoViewModel>(viewModel: AppDI.shared().getUserInfoViewModel())
        .environmentObject(AppDI.shared().getAuthViewModel())
}
