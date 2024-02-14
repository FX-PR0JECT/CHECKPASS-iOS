//
//  PasswordConfirmInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct PasswordConfirmInputView<SVM: UserInfoInputVM>: View {
    @EnvironmentObject private var viewModel: SVM
    @Binding private var pwConfirmInput: String
    @Binding private var idInput: String
    
    init(pwConfirmInput: Binding<String>, idInput: Binding<String>) {
        _pwConfirmInput = pwConfirmInput
        _idInput = idInput
    }
    
    var body: some View {
        VStack {
            UserInfoInputView(text: $pwConfirmInput,
                            inputState: Binding(
                                get: {
                                    self.viewModel.defaultStates["pwConfirmation"] ?? .isInitial
                                }, set: { newValue in
                                    self.viewModel.defaultStates["pwConfirmation"] = newValue
                                }
                            ),
                            header: "비밀번호 확인", placeholder: "비밀번호를 다시 한번 입력해 주세요", style: .secure)
            
            //MARK: - Warning Message
            if viewModel.defaultStates["pwConfirmation"] == .isInvalid || viewModel.defaultStates["pwConfirmation"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    if viewModel.defaultStates["pwConfirmation"] == .isInvalid {
                        Text("비밀번호가 일치하지 않아요")
                    } else if viewModel.defaultStates["pwConfirmation"] == .isBlank {
                        Text("비밀번호를 확인해 주세요")
                    }
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onTapGesture {
            if let signUpViewModel = viewModel as? SignUpVM {
                if viewModel.defaultStates["id"] == .isNotVerified {
                    signUpViewModel.executeIdDuplicateCheck(for: idInput)
                }
            }
        }
    }
}

#Preview {
    PasswordConfirmInputView<SignUpViewModel>(pwConfirmInput: .constant(""), idInput: .constant(""))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
