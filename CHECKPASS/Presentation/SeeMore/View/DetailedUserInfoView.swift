//
//  DetailedUserInfoView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/7/24.
//

import SwiftUI

struct DetailedUserInfoView<UVM: UserInfoVM>: View {
    @EnvironmentObject private var viewModel: UVM
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
                                        value: viewModel.detailedUserInfo?.userName ?? "")
                    
                    DetailedUserInfoRow(title: viewModel.detailedUserInfo?.userJob == .student ? "학번" : "교직원 번호",
                                        value: String(viewModel.detailedUserInfo?.userId ?? 0000000))
                    
                    DetailedUserInfoRow(title: "단과대",
                                        value: viewModel.detailedUserInfo?.userCollege ?? "")
                    
                    
                    DetailedUserInfoRow(title: "학과",
                                        value: viewModel.detailedUserInfo?.userDepartment ?? "")
                    
                }
                .listRowSeparator(.hidden)
                
                if let userInfo = viewModel.detailedUserInfo as? DetailedStudentInfo {
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
                } else if let userInfo = viewModel.detailedUserInfo as? DetailedStaffInfo {
                    //MARK: - Staff only
                    Section(header: BackgroundHeader(name: "", color: .listSeperator)) {
                        DetailedUserInfoRow(title: "구분",
                                            value: userInfo.userJob.toKorean())
                        
                        DetailedUserInfoRow(title: "입사일",
                                            value: userInfo.hireDate)
                    }
                    .listRowSeparator(.hidden)
                }
                
                Spacer()
                
                Button(action: {
                    showEditView.toggle()
                }, label: {
                    EditButton()
                })
                .buttonStyle(.borderless)
                .listRowSeparator(.hidden)
            }
            .listRowSpacing(15.0)
            .listStyle(.plain)
            .onAppear {
                if viewModel.detailedUserInfo == nil {
                    viewModel.getDetailedUserInfo()
                }
            }
            .navigationTitle("내 정보")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showEditView) {
                EditUserInfoView<UVM, _>(viewModel: AppDI.shared().getEditUserInfoViewModel(),
                                         showEditView: $showEditView)
                .environmentObject(viewModel)
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
