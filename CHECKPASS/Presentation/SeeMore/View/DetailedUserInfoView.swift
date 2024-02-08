//
//  DetailedUserInfoView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/7/24.
//

import SwiftUI

struct DetailedUserInfoView<UVM: UserInfoVM>: View {
    @EnvironmentObject private var userInfoViewModel: UVM
    
    var body: some View {
        List {
            HStack {
                Spacer()
                
                ProfileImage()
                
                Spacer()
            }
            .listRowSeparator(.hidden)
            
            Rectangle()
                .frame(height: 13)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .foregroundColor(Color(red: 243 / 255, green: 244 / 255, blue: 246 / 255))
            
            Section {
                DetailedUserInfoRow(title: "이름",
                                    value: userInfoViewModel.detailedUserInfo?.userName ?? "")
                
                DetailedUserInfoRow(title: userInfoViewModel.detailedUserInfo?.userJob == .student ? "학번" : "교직원 번호",
                                    value: String(userInfoViewModel.detailedUserInfo?.userId ?? 0000000))
                
                DetailedUserInfoRow(title: "단과대",
                                    value: userInfoViewModel.detailedUserInfo?.userCollege ?? "")
                
                
                DetailedUserInfoRow(title: "학과",
                                    value: userInfoViewModel.detailedUserInfo?.userDepartment ?? "")
                
            }
            .listRowSeparator(.hidden)
            
            Rectangle()
                .frame(height: 13)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .foregroundColor(Color(red: 243 / 255, green: 244 / 255, blue: 246 / 255))

            if let userInfo = userInfoViewModel.detailedUserInfo as? DetailedStudentInfo {
                //MARK: - Student only
                Section {
                    DetailedUserInfoRow(title: "구분",
                                        value: userInfo.userJob.toKorean())
                    
                    DetailedUserInfoRow(title: "학년",
                                        value: "\(userInfo.studentGrade) \(userInfo.studentSemester)")
                    
                    DetailedUserInfoRow(title: "주/야",
                                        value: userInfo.dayOrNight)
                }
                .listRowSeparator(.hidden)
            } else if let userInfo = userInfoViewModel.detailedUserInfo as? DetailedStaffInfo {
                //MARK: - Staff only
                Section {
                    DetailedUserInfoRow(title: "구분",
                                        value: userInfo.userJob.toKorean())
                    
                    DetailedUserInfoRow(title: "입사일",
                                        value: userInfo.hireDate)
                }
                .listRowSeparator(.hidden)
            }
        }
        .listRowSpacing(15.0)
        .listStyle(.plain)
        .onAppear {
            userInfoViewModel.getDetailedUserInfo()
        }
        .navigationTitle("상세정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailedUserInfoView<UserInfoViewModel>()
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
