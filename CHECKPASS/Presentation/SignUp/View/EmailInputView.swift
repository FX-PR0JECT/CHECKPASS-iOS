//
//  EmailInputview.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct EmailInputView: View {
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @Binding var emailInput: String
    
    var body: some View {
        VStack {
            SignUpInputView(text: $emailInput,
                            inputState: Binding(
                                get: {
                                    self.signUpViewModel.states["email"] ?? .isInitial
                                },
                                set: { newValue in
                                    self.signUpViewModel.states["email"] = newValue
                                }),
                            header: "이메일", placeholder: "이메일을 입력해 주세요", keyboardType: .emailAddress)
            
            //MARK: - Warning Message"
            if signUpViewModel.states["email"] == .isInvalid || signUpViewModel.states["email"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    if signUpViewModel.states["email"] == .isInvalid {
                        Text("이메일 형식이 올바르지 않아요")
                    } else if signUpViewModel.states["email"] == .isBlank {
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
                    signUpViewModel.states["email"] = .isBlank
                } else {
                    signUpViewModel.checkEmailValidation(newValue)
                }
            }
        }
    }
}

#Preview {
    EmailInputView(emailInput: .constant(""))
        .environmentObject(AppDI.shared.getSignUpViewModel())
}
