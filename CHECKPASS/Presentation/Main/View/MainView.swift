//
//  MainView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/24/24.
//

import SwiftUI

struct MainView<UVM: UserInfoVM>: View {
    @StateObject private var userInfoViewModel: UVM
    @State private var showCardView: Bool = false
    @Binding private var selectedTab: Tab
    
    init(viewModel: UVM, selectedTab: Binding<Tab>) {
        _userInfoViewModel = StateObject(wrappedValue: viewModel)
        _selectedTab = selectedTab
    }
    
    var body: some View {
        ScrollView {
            MainSubTitle("\(userInfoViewModel.simpleUserInfo?.userName ?? "") 님 안녕하세요!")
            
            ShortcutsView()
                .padding([.leading, .trailing])
            
            MainSubTitle("출석하기")
            
            HStack(spacing: 15) {
                NavigationLink(destination: {
                    //Beacon Attendance View
                }, label: {
                    MainMediumCard(title: "비콘으로\n출석하기",
                                   image: "",
                                   imageOffset: (0, 20))
                })
                
                NavigationLink(destination: {
                    //E-attendance View
                }, label: {
                    MainMediumCard(title: "전자출결로\n출석하기",
                                   image: "dart",
                                   imageOffset: (0, 20))
                })
            }
            .padding([.leading, .trailing])
            
            MainSubTitle("시간표")
            
            NavigationLink(destination: {
                //Timetable View
            }, label: {
                MainMediumCard(title: "시간표\n확인하기",
                               image: "calender 2")
            })
            .padding([.leading, .trailing])
        }
        .toolbar {
            if selectedTab == .main {
                ToolbarItem(placement: .topBarLeading) {
                    Image("CheckPassLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showCardView.toggle()
                    }, label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundColor(.gray)
                    })
                }
            }
        }
        .onAppear {
            if userInfoViewModel.simpleUserInfo == nil {
                userInfoViewModel.getSimpleUserInfo()
            }
        }
        .fullScreenCover(isPresented: $showCardView) {
            MobileIdCardView<UVM>(showCardView: $showCardView)
                .environmentObject(userInfoViewModel)
        }
    }
}

#Preview {
    MainView<UserInfoViewModel>(viewModel: AppDI.shared().getUserInfoViewModel() as! UserInfoViewModel, selectedTab: .constant(.main))
}
