//
//  SignUpView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

import SwiftUI

struct SignUpView<SVM: SignUpVM>: View {
    @EnvironmentObject var signUpViewModel: SVM
    @State private var idInput: String = ""
    @State private var pwInput: String = ""
    @State private var pwConfirmInput: String = ""
    @State private var nameInput: String = ""
    @State private var emailInput: String = ""
    @State private var selectedCollege: String = "선택"
    @State private var selectedDepartment: String = ""
    @State private var selectedHireDate: Date = Date(timeIntervalSince1970: 0)
    @State private var selectedGrade: String = ""
    @State private var selectedDayOrNight: String = ""
    @State private var selectedSemester: String = ""
    @Binding var selectedJob: JobType
    @Binding var showNextView: Bool
    @Binding var showSignUpView: Bool
    
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
                
                SignUpPickerView<SVM>(selection: $selectedDepartment, header: "학과", title: "학과를 선택해 주세요", contents: PickerContents.departments[selectedCollege]!, pos: "department")
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
                        if signUpViewModel.verifyState(job: selectedJob) {
                            print("all clear")
                        } else {
                            print("There is an invalid input")
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
    }
}

#Preview {
    SignUpView<SignUpViewModel>(selectedJob: .constant(.student), showNextView: .constant(true), showSignUpView: .constant(true))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
