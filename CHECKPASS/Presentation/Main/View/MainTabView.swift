//
//  MainView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/16/24.
//

import SwiftUI

struct MainTabView: View {
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
            
            SeeMoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    
                    Text("더보기")
                }
        }
    }
}

#Preview {
    MainTabView()
}
