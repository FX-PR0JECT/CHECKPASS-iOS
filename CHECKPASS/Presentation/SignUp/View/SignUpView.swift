//
//  SignUpView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

import SwiftUI
import UIKit

struct SignUpView<SVM: SignUpVM>: View {
    @EnvironmentObject private var signUpViewModel: SVM
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
                    .environmentObject(signUpViewModel)
                
                PasswordInputView<SVM>(pwInput: $pwInput)
                    .environmentObject(signUpViewModel)
                
                PasswordConfirmInputView<SVM>(pwConfirmInput: $pwConfirmInput)
                    .environmentObject(signUpViewModel)
                
                NameInputView<SVM>(nameInput: $nameInput)
                    .environmentObject(signUpViewModel)
                
                SignUpPickerView<SVM>(selection: $selectedCollege, header: "단과대", title: "단과대를 선택해 주세요", contents: PickerContents.colleges, pos: "college")
                    .environmentObject(signUpViewModel)
                
                SignUpPickerView<SVM>(selection: $selectedDepartment, header: "학과", title: "학과를 선택해 주세요", contents: PickerContents.departments[selectedCollege] ?? [], pos: "department")
                    .environmentObject(signUpViewModel)
                
                //MARK: - Staff Only
                Group {
                    if selectedJob == .professor || selectedJob == .staff {
                        HireDatePickerView<SVM>(selection: $selectedHireDate, header: "입사일", title: "입사일을 선택해 주세요")
                            .environmentObject(signUpViewModel)
                    }
                }
                
                //MARK: - Student Only
                Group {
                    if selectedJob == .student {
                        SignUpPickerView<SVM>(selection: $selectedGrade, header: "학년", title: "학년을 선택해 주세요", contents: PickerContents.grades, pos: "grade", type: .student)
                            .environmentObject(signUpViewModel)
                        
                        SignUpPickerView<SVM>(selection: $selectedSemester, header: "학기", title: "학기를 선택해 주세요", contents: PickerContents.semesters, pos: "semester", type: .student)
                            .environmentObject(signUpViewModel)
                        
                        SignUpPickerView<SVM>(selection: $selectedDayOrNight, header: "주/야", title: "주간/야간 구분을 선택해 주세요", contents: PickerContents.dayOrNight, pos:"dayOrNight", type: .student)
                            .environmentObject(signUpViewModel)
                    }
                }
                
                //MARK: - Terms Agreement
                TermsAgreementView<SVM>()
                    .environmentObject(signUpViewModel)
                
                Button(action: {
                    withAnimation {
                        dismissKeyboard()
                        
                        if let selectedJob = selectedJob, signUpViewModel.verifyState(job: selectedJob) {
                            switch selectedJob {
                            case .student:
                                signUpViewModel.executeStudentRegister(id: idInput,
                                                                       pw: pwInput, name: nameInput,
                                                                       job: selectedJob.getEnglishData(),
                                                                       collage: selectedCollege,
                                                                       department: selectedDepartment,
                                                                       grade: selectedGrade,
                                                                       dayOrNight: selectedDayOrNight,
                                                                       semester: selectedSemester)
                            case .professor, .staff:
                                signUpViewModel.executeStaffRegister(id: idInput, pw: pwInput, name: nameInput,
                                                                     job: selectedJob.getEnglishData(),
                                                                     collage: selectedCollege,
                                                                     department: selectedDepartment,
                                                                     hireDate: selectedHireDate.toYearMonthDay())
                            }
                        } else {
                            signUpViewModel.alertType = .inValidInput
                            signUpViewModel.isAlertVisible = true
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
                    signUpViewModel.defaultStates["pwConfirmation"] = .isValid
                } else if newValue.isEmpty {
                    signUpViewModel.defaultStates["pwConfirmation"] = .isBlank
                } else {
                    signUpViewModel.defaultStates["pwConfirmation"] = .isInvalid
                }
            }
        }
        .onDisappear {
            signUpViewModel.initializeStates()
        }
        .alert(isPresented: $signUpViewModel.isAlertVisible) {
            switch signUpViewModel.alertType {
            case .signUpSucceed:
                return Alert(title: Text("환영합니다!"),
                             message: Text("회원가입이 완료 되었어요"),
                             dismissButton: .default(Text("확인")) {
                                showNextView = false
                                showSignUpView = false
                            })
            case .signUpFailed:
                return Alert(title: Text("알림"),
                             message: Text("회원가입에 실패했어요"))
            case .inValidInput:
                return Alert(title: Text("알림"),
                             message: Text("잘못된 입력값이 있어요"))
            }
        }
    }
}

extension SignUpView {
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
