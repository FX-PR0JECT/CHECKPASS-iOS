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
    @State private var updateDepartment: String = "선택"
    @State private var updateStudentGrade: String = "선택"
    @State private var updateDayOrNight: String = "선택"
    @State private var updateStudentSemester: String = "선택"
    @State private var updateHireDate: Date = Date(timeIntervalSince1970: 0)
    
    init(viewModel: UIVM, showEditView: Binding<Bool>) {
        _userInfoInputViewModel = StateObject(wrappedValue: viewModel)
        _showEditView = showEditView
    }
    
    var body: some View {
        if userInfoInputViewModel.departments == nil {
            ProgressView()
                .scaleEffect(2)
                .onAppear {
                    if let updateName = userInfoViewModel.detailedUserInfo?.userName {
                        self.updateName = updateName
                    }
                    
                    if let updateDepartment = userInfoViewModel.detailedUserInfo?.userDepartment {
                        self.updateDepartment = updateDepartment
                    }
                    
                    if let detailedUserInfo = userInfoViewModel.detailedUserInfo as? DetailedStudentInfo {
                        self.updateStudentGrade = detailedUserInfo.studentGrade
                        self.updateDayOrNight = detailedUserInfo.dayOrNight
                        self.updateStudentSemester = detailedUserInfo.studentSemester
                    }
                    
                    if let detailedUserInfo = userInfoViewModel.detailedUserInfo as? DetailedStaffInfo {
                        if let hireDate = detailedUserInfo.hireDate.toDate() {
                            self.updateHireDate = hireDate
                        }
                    }
                    
                    if let detailedUserInfo = userInfoViewModel.detailedUserInfo {
                        userInfoInputViewModel.getDepartmentsData(of: detailedUserInfo.userCollege)
                    }
                }
        } else {
            ZStack {
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
                                                         pos: "grade",
                                                         type: .student)
                                    .environmentObject(userInfoInputViewModel)
                                
                                UserInfoPickerView<UIVM>(selection: $updateDayOrNight,
                                                         header: "주/야",
                                                         title: "주간/야간을 선택해 주세요",
                                                         contents: PickerContents.dayOrNight,
                                                         pos: "dayOrNight",
                                                         type: .student)
                                    .environmentObject(userInfoInputViewModel)
                                
                                UserInfoPickerView<UIVM>(selection: $updateStudentSemester,
                                                         header: "학기",
                                                         title: "학기를 선택해 주세요",
                                                         contents: PickerContents.semesters,
                                                         pos: "semesters",
                                                         type: .student)
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
                
                VStack {
                    Spacer()
                    
                    Button(action: {}, label: {
                        Text("수정완료")
                            .font(.subheadline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    })
                }
                .padding()
            }
        }
    }
}

#Preview {
    EditUserInfoView<UserInfoViewModel, _>(viewModel: AppDI.shared().getEditUserInfoViewModel(),
                                        showEditView: .constant(true))
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
