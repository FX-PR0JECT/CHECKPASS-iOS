//
//  EmailInputview.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct EmailInputView: View {
    @EnvironmentObject private var signUpViewModel: SignUpViewModel
    @Binding private var emailInput: String
    
    init(emailInput: Binding<String>) {
        _emailInput = emailInput
    }
    
    var body: some View {
        VStack {
            SignUpInputView(text: $emailInput,
                            inputState: Binding(
                                get: {
                                    self.signUpViewModel.defaultStates["email"] ?? .isInitial
                                },
                                set: { newValue in
                                    self.signUpViewModel.defaultStates["email"] = newValue
                                }),
                            header: "이메일", placeholder: "이메일을 입력해 주세요", keyboardType: .emailAddress)
            
            //MARK: - Warning Message"
            if signUpViewModel.defaultStates["email"] == .isInvalid || signUpViewModel.defaultStates["email"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    if signUpViewModel.defaultStates["email"] == .isInvalid {
                        Text("이메일 형식이 올바르지 않아요")
                    } else if signUpViewModel.defaultStates["email"] == .isBlank {
                        Text("이메일을 입력 해주세요")
                    }
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onChange(of: emailInput) { newValue in
            withAnimation {
                if newValue.isEmpty {
                    signUpViewModel.defaultStates["email"] = .isBlank
                } else {
                    signUpViewModel.checkEmailValidation(newValue)
                }
            }
        }
    }
}

#Preview {
    EmailInputView(emailInput: .constant(""))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
