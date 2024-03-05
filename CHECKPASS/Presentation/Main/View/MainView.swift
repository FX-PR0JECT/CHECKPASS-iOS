//
//  MainView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/24/24.
//

import SwiftUI

struct MainView<UVM: UserInfoVM>: View {
    @EnvironmentObject private var userInfoViewModel: UVM
    @State private var showCardView: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                MainSubTitle("\(userInfoViewModel.simpleUserInfo?.userName ?? "") 님 안녕하세요!")
                
                ShortcutsScrollView()
                
                MainSubTitle("출석하기")
                
                HStack(spacing: 15) {
                    NavigationLink(destination: {
                        //Beacon Attendance View
                    }, label: {
                        MainMediumCard(title: "비콘으로\n출석하기",
                                       image: "mobile",
                                       imageOffset: (-13, 20),
                                       scale: 0.21)
                    })
                    
                    NavigationLink(destination: {
                        EAttendanceList(viewModel: AppDI.shared().getEAttendanceViewModel())
                    }, label: {
                        MainMediumCard(title: "전자출결로\n출석하기",
                                       image: "dart",
                                       imageOffset: (0, 20))
                    })
                }
                .padding([.leading, .trailing, .bottom])
                
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
}

#Preview {
    MainView<UserInfoViewModel>()
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
