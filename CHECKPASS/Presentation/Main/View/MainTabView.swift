//
//  MainView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/16/24.
//

import SwiftUI

struct MainTabView<T: AuthVM, U: UserInfoVM, R: RecentlyEnrolledLectureViewModel>: View {
    @StateObject private var userInfoViewModel: U
    @StateObject private var recentlyEnrolledLectureViewModel: R
    @EnvironmentObject private var authViewModel: T
    
    init(userInfoViewModel: U, recentlyEnrolledLectureViewModel: R) {
        _userInfoViewModel = StateObject(wrappedValue: userInfoViewModel)
        _recentlyEnrolledLectureViewModel = StateObject(wrappedValue: recentlyEnrolledLectureViewModel)
    }
    
    var body: some View {
        TabView() {
            MainView<U, R>()
                .environmentObject(userInfoViewModel)
                .environmentObject(recentlyEnrolledLectureViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    
                    Text("홈")
                }
            
            LectureHistoryList(viewModel: AppDI.shared().getLectureHistoryViewModel())
                .tabItem {
                    Image(systemName: "graduationcap.fill")
                    
                    Text("내 강의")
                }
            
            BoardView()
                .tabItem {
                    Image(systemName: "ellipsis.message")
                    
                    Text("게시판")
                }
            
            SeeMoreView<T, U>()
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
    MainTabView<AuthViewModel, UserInfoViewModel, DefaultRecentlyEnrolledLectureViewModel>(userInfoViewModel: AppDI.shared().getUserInfoViewModel(),
                                                  recentlyEnrolledLectureViewModel:  AppDI.shared().getRecentlyEnrolledLectureViewModel())
        .environmentObject(AppDI.shared().getAuthViewModel())
}
