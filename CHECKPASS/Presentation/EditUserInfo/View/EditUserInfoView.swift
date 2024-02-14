//
//  EditUserInfoView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/13/24.
//

import SwiftUI

struct EditUserInfoView<UVM: UserInfoVM, UIVM: UserInfoInputVM>: View {
    @StateObject private var userInfoInputViewModel: UIVM
    @EnvironmentObject private var userInfoViewModel: UVM
    @Binding private var showEditView: Bool
    @State private var updateName: String = ""
    @State private var updateDepartment: String = ""
    @State private var updateStudentGrade: String = ""
    @State private var updateDayOrNight: String = ""
    @State private var updateStudentSemester: String = ""
    @State private var updateHireDate: Date = Date(timeIntervalSince1970: 0)
    
    init(viewModel: UIVM, showEditView: Binding<Bool>) {
        _userInfoInputViewModel = StateObject(wrappedValue: viewModel)
        _showEditView = showEditView
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                NameInputView<UIVM>(nameInput: $updateName)
                    .environmentObject(userInfoInputViewModel)
                
                UserInfoPickerView<UIVM>(selection: $updateDepartment,
                                   header: "학과",
                                   title: "학과를 선택해 주세요",
                                   contents: userInfoInputViewModel.departments?.departmentList ?? [],
                                   pos: "department")
                    .environmentObject(userInfoInputViewModel)

                //MARK: For Student
                if userInfoViewModel.detailedUserInfo is DetailedStudentInfo {
                    Group {
                        UserInfoPickerView<UIVM>(selection: $updateStudentGrade,
                                           header: "학년",
                                           title: "학년을 선택해 주세요",
                                           contents: PickerContents.grades,
                                           pos: "grade")
                            .environmentObject(userInfoInputViewModel)
                        
                        UserInfoPickerView<UIVM>(selection: $updateDayOrNight,
                                           header: "주/야",
                                           title: "주간/야간을 선택해 주세요",
                                           contents: PickerContents.dayOrNight,
                                           pos: "dayOrNight")
                            .environmentObject(userInfoInputViewModel)
                        
                        UserInfoPickerView<UIVM>(selection: $updateStudentSemester,
                                           header: "학기",
                                           title: "학기를 선택해 주세요",
                                           contents: PickerContents.semesters,
                                           pos: "semesters")
                            .environmentObject(userInfoInputViewModel)
                    }
                }
                
                //MARK: For Staff
                if userInfoViewModel.detailedUserInfo is DetailedStaffInfo {
                    Group {
                        HireDatePickerView<UIVM>(selection: $updateHireDate,
                                                 header: "입사일",
                                                 title: "입사일을 선택해 주세요")
                            .environmentObject(userInfoInputViewModel)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("내 정보 수정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: {}, label: {
                    Text("수정완료")
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                })
                .buttonStyle(.borderless)
            }
        }
        .onAppear {
            if let updateName = userInfoViewModel.detailedUserInfo?.userName {
                self.updateName = updateName
            }
            
            if let updateDepartment = userInfoViewModel.detailedUserInfo?.userDepartment {
                self.updateDepartment = updateDepartment
            }
            
            if let detailUserInfo = userInfoViewModel.detailedUserInfo as? DetailedStudentInfo {
                self.updateStudentGrade = detailUserInfo.studentGrade
                self.updateDayOrNight = detailUserInfo.dayOrNight
                self.updateStudentSemester = detailUserInfo.studentSemester
            }
        }
    }
}

#Preview {
    EditUserInfoView<UserInfoViewModel, _>(viewModel: AppDI.shared().getEditUserInfoViewModel(),
                                        showEditView: .constant(true))
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
