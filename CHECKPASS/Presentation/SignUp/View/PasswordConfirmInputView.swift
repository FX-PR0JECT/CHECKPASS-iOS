//
//  PasswordConfirmInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct PasswordConfirmInputView<SVM: SignUpVM>: View {
    @EnvironmentObject var signUpViewModel: SVM
    @Binding var pwConfirmInput: String
    
    var body: some View {
        VStack {
            SignUpInputView(text: $pwConfirmInput,
                            inputState: Binding(
                                get: {
                                    self.signUpViewModel.defaultStates["pwConfirmation"] ?? .isInitial
                                }, set: { newValue in
                                    self.signUpViewModel.defaultStates["pwConfirmation"] = newValue
                                }
                            ),
                            header: "비밀번호 확인", placeholder: "비밀번호를 다시 한번 입력해 주세요", style: .secure)
            
            //MARK: - Warning Message
            if signUpViewModel.defaultStates["pwConfirmation"] == .isInvalid || signUpViewModel.defaultStates["pwConfirmation"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    if signUpViewModel.defaultStates["pwConfirmation"] == .isInvalid {
                        Text("비밀번호가 일치하지 않아요")
                    } else if signUpViewModel.defaultStates["pwConfirmation"] == .isBlank {
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
    PasswordConfirmInputView<SignUpViewModel>(pwConfirmInput: .constant(""))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
