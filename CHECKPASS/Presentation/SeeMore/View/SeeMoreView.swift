//
//  SeeMoreView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/24/24.
//

import SwiftUI

struct SeeMoreView<AVM: AuthVM, UVM: UserInfoVM>: View {
    @EnvironmentObject private var authViewModel: AVM
    @EnvironmentObject private var userInfoViewModel: UVM
    @State private var showLogoutAlert: Bool = false
    @State private var showDetailUserInfo: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button(action: {
                        showDetailUserInfo.toggle()
                    }, label: {
                        #if DEBUG
                        UserCard(simpleUserInfo: .constant(SimpleUserInfo.sampleData))
                        #else
                        UserCard(simpleUserInfo: $userInfoViewModel.simpleUserInfo)
                        #endif
                    })
                    .listRowSeparator(.hidden)
                }
                
                Section(header: Sectionheader(header: "계정 관리")) {
                    Button(action: {
                        showLogoutAlert.toggle()
                    }, label: {
                        Text("로그아웃")
                            .foregroundColor(.red)
                    })
                    .listRowSeparator(.hidden)
                    .alert("계정에서 로그아웃 하시겠어요?", isPresented: $showLogoutAlert) {
                        Button(role: .destructive) {
                            authViewModel.executeLogout()
                        } label: {
                            Text("로그아웃")
                        }
                    }
                }
                .listSectionSeparator(.visible, edges: .bottom)
            }
            .navigationTitle("더보기")
            .navigationBarTitleDisplayMode(.large)
            .listStyle(.plain)
            .fullScreenCover(isPresented: $showDetailUserInfo) {
                DetailedUserInfoView<UVM>(showDetailUserInfo: $showDetailUserInfo)
                    .environmentObject(userInfoViewModel)
            }
        }
    }
}

#Preview {
    SeeMoreView<AuthViewModel, UserInfoViewModel>()
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
