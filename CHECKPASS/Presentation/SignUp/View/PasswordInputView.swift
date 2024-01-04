//
//  PasswordInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct PasswordInputView: View {
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @Binding var pwInput: String
    
    var body: some View {
        VStack {
            SignUpInputView(text: $pwInput,
                            inputState: Binding(
                                get: {
                                    self.signUpViewModel.states["pw"] ?? .isInitial
                                }, set: { newValue in
                                    self.signUpViewModel.states["pw"] = newValue
                                }
                            ),
                            header: "비밀번호", placeholder: "비밀번호를 입력해 주세요", style: .secure)
            
            //MARK: - Warning Message
            if signUpViewModel.states["pw"] == .isInvalid || signUpViewModel.states["pw"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    if signUpViewModel.states["pw"] == .isInvalid {
                        Text("비밀번호는 영문, 숫자, 특수문자 포함 8~16자리")
                    } else if signUpViewModel.states["pw"] == .isBlank {
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
                    signUpViewModel.states["pw"] = .isBlank
                } else {
                    signUpViewModel.checkPwValidation(newValue)
                }
            }
        }
    }
}

#Preview {
    PasswordInputView(pwInput: .constant(""))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
