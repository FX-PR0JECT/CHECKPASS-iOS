//
//  SignUpView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

import SwiftUI
import UIKit

struct SignUpView<SVM: UserInfoInputVM & SignUpVM>: View {
    @EnvironmentObject private var viewModel: SVM
    @State private var idInput: String = ""
    @State private var pwInput: String = ""
    @State private var pwConfirmInput: String = ""
    @State private var nameInput: String = ""
    @State private var selectedCollege: String = "선택"
    @State private var selectedDepartment: String = "선택"
    @State private var selectedHireDate: Date = Date(timeIntervalSince1970: 0)
    @State private var selectedGrade: String = "선택"
    @State private var selectedDayOrNight: String = "선택"
    @State private var selectedSemester: String = "선택"
    @Binding private var selectedJob: JobType?
    @Binding private var showNextView: Bool
    @Binding private var showSignUpView: Bool
    
    init(selectedJob: Binding<JobType?>, showNextView: Binding<Bool>, showSignUpView: Binding<Bool>) {
        _selectedJob = selectedJob
        _showNextView = showNextView
        _showSignUpView = showSignUpView
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                //MARK: - Default Input
                IdInputView<SVM>(idInput: $idInput)
                    .environmentObject(viewModel)
                
                PasswordInputView<SVM>(pwInput: $pwInput, idInput: $idInput)
                    .environmentObject(viewModel)
                
                PasswordConfirmInputView<SVM>(pwConfirmInput: $pwConfirmInput, idInput: $idInput)
                    .environmentObject(viewModel)
                
                NameInputView<SVM>(nameInput: $nameInput, idInput: $idInput)
                    .environmentObject(viewModel)
                
                UserInfoPickerView<SVM>(selection: $selectedCollege, idInput: $idInput, header: "단과대", title: "단과대를 선택해 주세요", contents: viewModel.colleges?.collegeList ?? [], pos: "college")
                    .environmentObject(viewModel)
                
                UserInfoPickerView<SVM>(selection: $selectedDepartment, idInput: $idInput, header: "학과", title: "학과를 선택해 주세요", contents: viewModel.departments?.departmentList ?? [], pos: "department")
                    .environmentObject(viewModel)
                
                //MARK: - Staff Only
                Group {
                    if selectedJob == .professor || selectedJob == .staff {
                        HireDatePickerView<SVM>(selection: $selectedHireDate, idInput: $idInput, header: "입사일", title: "입사일을 선택해 주세요")
                            .environmentObject(viewModel)
                    }
                }
                
                //MARK: - Student Only
                Group {
                    if selectedJob == .student {
                        UserInfoPickerView<SVM>(selection: $selectedGrade, idInput: $idInput, header: "학년", title: "학년을 선택해 주세요", contents: PickerContents.grades, pos: "grade", type: .student)
                            .environmentObject(viewModel)
                        
                        UserInfoPickerView<SVM>(selection: $selectedSemester, idInput: $idInput, header: "학기", title: "학기를 선택해 주세요", contents: PickerContents.semesters, pos: "semester", type: .student)
                            .environmentObject(viewModel)
                        
                        UserInfoPickerView<SVM>(selection: $selectedDayOrNight, idInput: $idInput, header: "주/야", title: "주간/야간 구분을 선택해 주세요", contents: PickerContents.dayOrNight, pos:"dayOrNight", type: .student)
                            .environmentObject(viewModel)
                    }
                }
                
                //MARK: - Terms Agreement
                TermsAgreementView<SVM>()
                    .environmentObject(viewModel)
                
                Button(action: {
                    dismissKeyboard()    //keyboard down
                    
                    selectedJob.map { selectedJob in
                        switch selectedJob {
                        case .student:
                            viewModel.registerForStudent(id: idInput,
                                                               pw: pwInput, name: nameInput,
                                                               job: selectedJob.rawValue,
                                                               college: selectedCollege,
                                                               department: selectedDepartment,
                                                               grade: selectedGrade,
                                                               dayOrNight: selectedDayOrNight,
                                                               semester: selectedSemester)
                        case .professor, .staff:
                            viewModel.registerForStaff(id: idInput, pw: pwInput, name: nameInput,
                                                             job: selectedJob.rawValue,
                                                             college: selectedCollege,
                                                             department: selectedDepartment,
                                                             hireDate: selectedHireDate.toYearMonthDay())
                        }
                    }
                }, label: {
                    Text("회원가입")
                        .bold()
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(30)
                    
                })
            }
            .padding()
        }
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.large)
        .onChange(of: pwConfirmInput) { newValue in
            withAnimation {
                if pwInput == pwConfirmInput {
                    viewModel.defaultStates["pwConfirmation"] = .isValid
                } else if newValue.isEmpty {
                    viewModel.defaultStates["pwConfirmation"] = .isBlank
                } else {
                    viewModel.defaultStates["pwConfirmation"] = .isInvalid
                }
            }
        }
        .onChange(of: selectedCollege) { newValue in
            if newValue != "선택" {
                viewModel.getDepartmentsData(of: newValue)
            }
        }
        .onDisappear {
            viewModel.initializeStates()
        }
        .alert(isPresented: $viewModel.isAlertVisible) {
            switch viewModel.alertType {
            case .requestSucceed:
                return Alert(title: Text("환영합니다!"),
                             message: Text("회원가입이 완료 되었어요"),
                             dismissButton: .default(Text("확인")) {
                                showNextView = false
                                showSignUpView = false
                            })
            case .requestFailed:
                return Alert(title: Text("알림"),
                             message: Text("회원가입에 실패했어요"))
            case .isInValidInput:
                return Alert(title: Text("알림"),
                             message: Text("잘못된 입력값이 있어요"))
            case .isBlank:
                return Alert(title: Text("알림"),
                             message: Text("입력되지 않은 값이 있어요"))
            }
        }
        .onAppear {
            //fetch colleges data when view appear
            viewModel.getCollegesData()
        }
    }
}

extension View {
    //MARK: - keyboard dismiss method
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Date {
    func toYearMonthDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
}

#Preview {
    SignUpView<SignUpViewModel>(selectedJob: .constant(.student), showNextView: .constant(true), showSignUpView: .constant(true))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
