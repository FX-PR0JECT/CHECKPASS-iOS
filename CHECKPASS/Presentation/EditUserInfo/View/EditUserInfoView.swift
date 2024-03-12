//
//  EditUserInfoView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/13/24.
//

import SwiftUI
import Combine

struct EditUserInfoView<UVM: UserInfoVM, UEVM: UserInfoInputVM & EditUserInfoVM>: View {
    @ObservedObject private var editUserInfoViewModel: UEVM
    @EnvironmentObject private var userInfoViewModel: UVM
    @Binding private var showEditView: Bool
    @State private var updateName: String = ""
    @State private var updateDepartment: String = "선택"
    @State private var updateStudentGrade: String = "선택"
    @State private var updateDayOrNight: String = "선택"
    @State private var updateStudentSemester: String = "선택"
    @State private var updateHireDate: Date = Date(timeIntervalSince1970: 0)
    
    init(viewModel: UEVM, showEditView: Binding<Bool>) {
        _editUserInfoViewModel = ObservedObject(wrappedValue: viewModel)
        _showEditView = showEditView
    }
    
    var body: some View {
        if editUserInfoViewModel.departments == nil {
            ProgressView()
                .scaleEffect(2)
                .onAppear {
                    updateProperty()
                }
        } else {
            ScrollView {
                VStack(spacing: 25) {
                    NameInputView<UEVM>(nameInput: $updateName)
                        .environmentObject(editUserInfoViewModel)
                    
                    UserInfoPickerView<UEVM>(selection: $updateDepartment,
                                             header: "학과",
                                             title: "학과를 선택해 주세요",
                                             contents: editUserInfoViewModel.departments?.departmentList ?? [],
                                             pos: "department")
                    .environmentObject(editUserInfoViewModel)
                    
                    //MARK: - For Student
                    if userInfoViewModel.detailedUserInfo is DetailedStudentInfo {
                        UserInfoPickerView<UEVM>(selection: $updateStudentGrade,
                                                 header: "학년",
                                                 title: "학년을 선택해 주세요",
                                                 contents: PickerContents.grades,
                                                 pos: "grade",
                                                 type: .student)
                        .environmentObject(editUserInfoViewModel)
                        
                        UserInfoPickerView<UEVM>(selection: $updateDayOrNight,
                                                 header: "주/야",
                                                 title: "주간/야간을 선택해 주세요",
                                                 contents: PickerContents.dayOrNight,
                                                 pos: "dayOrNight",
                                                 type: .student)
                        .environmentObject(editUserInfoViewModel)
                        
                        UserInfoPickerView<UEVM>(selection: $updateStudentSemester,
                                                 header: "학기",
                                                 title: "학기를 선택해 주세요",
                                                 contents: PickerContents.semesters,
                                                 pos: "semesters",
                                                 type: .student)
                        .environmentObject(editUserInfoViewModel)
                    }
                    
                    //MARK: - For Staff
                    if userInfoViewModel.detailedUserInfo is DetailedStaffInfo {
                        HireDatePickerView<UEVM>(selection: $updateHireDate,
                                                 header: "입사일",
                                                 title: "입사일을 선택해 주세요")
                        .environmentObject(editUserInfoViewModel)
                    }
                }
                .padding()
            }
            .navigationTitle("내 정보 수정")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: updateName, perform: { newValue in
                editUserInfoViewModel.compare(getUserObject(), userInfoViewModel.detailedUserInfo)
            })
            .onChange(of: updateDepartment, perform: { newValue in
                editUserInfoViewModel.compare(getUserObject(), userInfoViewModel.detailedUserInfo)
            })
            .onChange(of: updateHireDate, perform: { newValue in
                editUserInfoViewModel.compare(getUserObject(), userInfoViewModel.detailedUserInfo)
            })
            .onChange(of: updateStudentGrade, perform: { newValue in
                editUserInfoViewModel.compare(getUserObject(), userInfoViewModel.detailedUserInfo)
            })
            .onChange(of: updateDayOrNight, perform: { newValue in
                editUserInfoViewModel.compare(getUserObject(), userInfoViewModel.detailedUserInfo)
            })
            .onChange(of: updateStudentSemester, perform: { newValue in
                editUserInfoViewModel.compare(getUserObject(), userInfoViewModel.detailedUserInfo)
            })
            .onDisappear {
                editUserInfoViewModel.departments = nil
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        if userInfoViewModel.detailedUserInfo is DetailedStudentInfo {
                            editUserInfoViewModel.executeForStudent(updateName: updateName,
                                                                    updateDepartment: updateDepartment,
                                                                    updateStudentGrade: updateStudentGrade,
                                                                    updateDayOrNight: updateDayOrNight,
                                                                    updateStudentSemester: updateStudentSemester)
                        } else {
                            editUserInfoViewModel.executeForStaff(updateName: updateName,
                                                                  updateDepartment: updateDepartment,
                                                                  updateHireDate: updateHireDate.formatDateToString(format: "yyyy-MM-dd"))
                        }
                    }, label: {
                        Text("수정하기")
                            .padding(8)
                            .frame(maxWidth: .infinity)
                    })
                    .disabled(!(editUserInfoViewModel.isChanged))
                    .buttonBorderShape(.roundedRectangle)
                    .cornerRadius(30)
                    .buttonStyle(.borderedProminent)
                    .alert(isPresented: $editUserInfoViewModel.isAlertVisible) {
                        switch editUserInfoViewModel.alertType {
                        case .requestSucceed:
                            Alert(title: Text("알림"),
                                  message: Text("개인정보 수정이 완료 되었어요"),
                                  dismissButton: .default(Text("확인")) {
                                userInfoViewModel.detailedUserInfo = nil
                                userInfoViewModel.simpleUserInfo = nil
                                
                                userInfoViewModel.getSimpleUserInfo()
                                userInfoViewModel.getDetailedUserInfo()
                                
                                showEditView.toggle()
                            })
                        case .requestFailed:
                            Alert(title: Text("알림"),
                                  message: Text("개인정보를 수정할 수 없습니다\n관리자에게 문의하세요"),
                                  dismissButton: .default(Text("확인")))
                        default:
                            Alert(title: Text("알림"),
                                  message: Text("잘못 입력된 값이 있어요"))
                        }
                    }
                }
            }
        }
    }
}

extension EditUserInfoView {
    private func getUserObject() -> User? {
        if let userInfo = userInfoViewModel.detailedUserInfo {
            switch userInfo.userJob {
            case .student:
                return DetailedStudentInfo(userId: userInfo.userId,
                                           userCollege: userInfo.userCollege,
                                           userDepartment: updateDepartment,
                                           userName: updateName,
                                           studentGrade: updateStudentGrade,
                                           dayOrNight: updateDayOrNight,
                                           studentSemester: updateStudentSemester,
                                           userJob: .student)
            case .professor, .staff:
                return DetailedStaffInfo(userId: userInfo.userId,
                                         userCollege: userInfo.userCollege,
                                         userDepartment: updateDepartment,
                                         userName: updateName,
                                         hireDate: updateHireDate.formatDateToString(format: "yyyy-MM-dd"),
                                         userJob: userInfo.userJob)
            }
        }
        
        return nil
    }
    
    private func updateProperty() {
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
            editUserInfoViewModel.getDepartmentsData(of: detailedUserInfo.userCollege)
        }
    }
}

#Preview {
    EditUserInfoView<UserInfoViewModel, _>(viewModel: AppDI.shared().getEditUserInfoViewModel(),
                                        showEditView: .constant(true))
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
