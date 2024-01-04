//
//  PasswordConfirmInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct PasswordConfirmInputView: View {
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @Binding var pwConfirmInput: String
    
    var body: some View {
        VStack {
            SignUpInputView(text: $pwConfirmInput,
                            inputState: Binding(
                                get: {
                                    self.signUpViewModel.states["pwConfirmation"] ?? .isInitial
                                }, set: { newValue in
                                    self.signUpViewModel.states["pwConfirmation"] = newValue
                                }
                            ),
                            header: "비밀번호 확인", placeholder: "비밀번호를 다시 한번 입력해 주세요", style: .secure)
            
            //MARK: - Warning Message
            if signUpViewModel.states["pwConfirmation"] == .isInvalid || signUpViewModel.states["pwConfirmation"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    if signUpViewModel.states["pwConfirmation"] == .isInvalid {
                        Text("비밀번호가 일치하지 않아요")
                    } else if signUpViewModel.states["pwConfirmation"] == .isBlank {
                        Text("비밀번호를 확인해 주세요")
                    }
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    PasswordConfirmInputView(pwConfirmInput: .constant(""))
        .environmentObject(AppDI.shared.getSignUpViewModel())
}
