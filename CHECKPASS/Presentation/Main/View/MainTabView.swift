//
//  MainView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/16/24.
//

import SwiftUI

enum Tab {
    case main
    case myLectures
    case board
    case seeMore
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .main
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView(viewModel: AppDI.shared().getUserInfoViewModel() as! UserInfoViewModel,
                     selectedTab: $selectedTab)
                .tag(Tab.main)
                .tabItem {
                    Image(systemName: "house.fill")
                    
                    Text("홈")
                }
            
            MyLectureListView()
                .tag(Tab.myLectures)
                .tabItem {
                    Image(systemName: "person.bust")
                    
                    Text("내 강의")
                }
            
            BoardView()
                .tag(Tab.board)
                .tabItem {
                    Image(systemName: "ellipsis.message")
                    
                    Text("게시판")
                }
            
            SeeMoreView()
                .tag(Tab.seeMore)
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
