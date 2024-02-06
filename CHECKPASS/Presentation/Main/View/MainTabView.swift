//
//  MainView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/16/24.
//

import SwiftUI

struct MainTabView<AVM: AuthViewModel>: View {
    @EnvironmentObject private var authViewModel: AVM
    
    var body: some View {
        TabView() {
            MainView(viewModel: AppDI.shared().getUserInfoViewModel() as! UserInfoViewModel)
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
            
            SeeMoreView<AVM>()
                .environmentObject(authViewModel)
                .tabItem {
                    Image(systemName: "ellipsis")
                    
                    Text("더보기")
                }
        }
    }
}

#Preview {
    MainTabView<DefaultAuthViewModel>()
        .environmentObject(AppDI.shared().getAuthViewModel())
}
