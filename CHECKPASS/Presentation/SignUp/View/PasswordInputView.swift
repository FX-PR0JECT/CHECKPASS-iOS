//
//  PasswordInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct PasswordInputView<SVM: SignUpVM>: View {
    @EnvironmentObject private var signUpViewModel: SVM
    @Binding private var pwInput: String
    @Binding private var idInput: String
    
    init(pwInput: Binding<String>, idInput: Binding<String>) {
        _pwInput = pwInput
        _idInput = idInput
    }
    
    var body: some View {
        VStack {
            SignUpInputView(text: $pwInput,
                            inputState: Binding(
                                get: {
                                    self.signUpViewModel.defaultStates["pw"] ?? .isInitial
                                }, set: { newValue in
                                    self.signUpViewModel.defaultStates["pw"] = newValue
                                }
                            ),
                            header: "비밀번호", placeholder: "비밀번호를 입력해 주세요", style: .secure)
            
            //MARK: - Warning Message
            if signUpViewModel.defaultStates["pw"] == .isInvalid || signUpViewModel.defaultStates["pw"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    if signUpViewModel.defaultStates["pw"] == .isInvalid {
                        Text("비밀번호는 영문, 숫자, 특수문자 포함 8~16자리")
                    } else if signUpViewModel.defaultStates["pw"] == .isBlank {
                        Text("비밀번호를 입력해 주세요")
                    }
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onChange(of: pwInput) { newValue in
            withAnimation {
                if newValue.isEmpty {
                    signUpViewModel.defaultStates["pw"] = .isBlank
                } else {
                    signUpViewModel.checkPwValidation(newValue)
                }
            }
        }
        .onTapGesture {
            if signUpViewModel.defaultStates["id"] == .isNotVerified {
                signUpViewModel.executeIdDuplicateCheck(for: idInput)
            }
        }
    }
}

#Preview {
    PasswordInputView<SignUpViewModel>(pwInput: .constant(""), idInput: .constant(""))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
