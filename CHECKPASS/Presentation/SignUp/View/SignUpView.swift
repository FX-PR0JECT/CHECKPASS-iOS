//
//  SignUpView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

import SwiftUI

struct SignUpView<SVM: SignUpVM>: View {
    @StateObject var signUpViewModel: SVM
    @State private var idInput: String = ""
    @State private var pwInput: String = ""
    @State private var pwConfirmInput: String = ""
    @State private var nameInput: String = ""
    @State private var emailInput: String = ""
    @State private var pickedJob: String = ""
    @State private var pickedCollege: String = "선택"
    @State private var pickedDepartment: String = ""
    
    var body: some View {        
        ScrollView {
            VStack(spacing: 25) {
                IdInputView(idInput: $idInput)
                    .environmentObject(signUpViewModel)
                
                PasswordInputView(pwInput: $pwInput)
                    .environmentObject(signUpViewModel)
                
                PasswordConfirmInputView(pwConfirmInput: $pwConfirmInput)
                    .environmentObject(signUpViewModel)
                
                NameInputView(nameInput: $nameInput)
                    .environmentObject(signUpViewModel)
                
                EmailInputView(emailInput: $emailInput)
                    .environmentObject(signUpViewModel)
                
                SignUpPickerView(selection: $pickedJob, header: "구분", title: "구분을 선택해 주세요", contents: PickerContents.userTypes, pos: "job")
                    .environmentObject(signUpViewModel)
                
                SignUpPickerView(selection: $pickedCollege, header: "단과대", title: "단과대를 선택해 주세요", contents: PickerContents.colleges, pos: "college")
                    .environmentObject(signUpViewModel)
                
                SignUpPickerView(selection: $pickedDepartment, header: "학과", title: "학과를 선택해 주세요", contents: PickerContents.departments[pickedCollege]!, pos: "department")
                    .environmentObject(signUpViewModel)
                
                TermsAgreementView()
                    .environmentObject(signUpViewModel)
                
                Button(action: {
                    withAnimation {
                        if signUpViewModel.verifyState() {
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
                    signUpViewModel.states["pwConfirmation"] = .isValid
                } else if newValue.isEmpty {
                    signUpViewModel.states["pwConfirmation"] = .isBlank
                } else {
                    signUpViewModel.states["pwConfirmation"] = .isInvalid
                }
            }
        }
    }
}

#Preview {
    SignUpView(signUpViewModel: AppDI.shared.getSignUpViewModel())
}
