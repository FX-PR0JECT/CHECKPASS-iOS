//
//  DetailedUserInfoView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/7/24.
//

import SwiftUI

struct DetailedUserInfoView<UVM: UserInfoVM>: View {
    @EnvironmentObject private var userInfoViewModel: UVM
    @State private var showEditView: Bool = false
    @Binding var showDetailUserInfo: Bool
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Spacer()
                    
                    ProfileImage()
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
                
                Section(header: BackgroundHeader(name: "", color: .listSeperator)) {
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
                
                if let userInfo = userInfoViewModel.detailedUserInfo as? DetailedStudentInfo {
                    //MARK: - Student only
                    Section(header: BackgroundHeader(name: "", color: .listSeperator)) {
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
                    Section(header: BackgroundHeader(name: "", color: .listSeperator)) {
                        DetailedUserInfoRow(title: "구분",
                                            value: userInfo.userJob.toKorean())
                        
                        DetailedUserInfoRow(title: "입사일",
                                            value: userInfo.hireDate)
                    }
                    .listRowSeparator(.hidden)
                }
                
                Button(action: {
                    showEditView.toggle()
                }, label: {
                    EditButton()
                })
                .buttonStyle(.borderless)
                .listRowSeparator(.hidden)
                .padding(.top, 30)
            }
            .listRowSpacing(15.0)
            .listStyle(.plain)
            .onAppear {
                if userInfoViewModel.detailedUserInfo == nil {
                    userInfoViewModel.getDetailedUserInfo()
                }
            }
            .navigationTitle("내 정보")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showEditView) {
                EditUserInfoView<UVM, _>(viewModel: AppDI.shared().getEditUserInfoViewModel(),
                                         showEditView: $showEditView)
                .environmentObject(userInfoViewModel)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showDetailUserInfo.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    })
                }
            }
        }
    }
}

#Preview {
    DetailedUserInfoView<UserInfoViewModel>(showDetailUserInfo: .constant(true))
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
