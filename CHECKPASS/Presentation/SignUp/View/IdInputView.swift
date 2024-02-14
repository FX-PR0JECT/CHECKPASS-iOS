//
//  IdInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct IdInputView<SVM: UserInfoInputVM>: View {
    @EnvironmentObject private var signUpViewModel: SVM
    @Binding private var idInput: String
    
    init(idInput: Binding<String>) {
        _idInput = idInput
    }
    
    var body: some View {
        VStack {
            UserInfoInputView(text: $idInput,
                            inputState: Binding(
                                get: {
                                    self.signUpViewModel.defaultStates["id"] ?? .isInitial
                                }, set: { newValue in
                                    self.signUpViewModel.defaultStates["id"] = newValue
                                }
                            ), header: "아이디", placeholder: "학번 또는 교직원 번호를 입력해 주세요", keyboardType: .numberPad)
            
            //MARK: - Warning Message
            if signUpViewModel.defaultStates["id"] == .isBlank ||
                signUpViewModel.defaultStates["id"] == .isInvalid ||
                signUpViewModel.defaultStates["id"] == .isValid
            {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    if signUpViewModel.defaultStates["id"] == .isBlank {
                        Text("아이디를 입력해 주세요")
                    } else if signUpViewModel.defaultStates["id"] == .isInvalid {
                        Text("이미 존재하는 회원이에요")
                    } else {
                        Text("사용할 수 있는 아이디에요")
                    }
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(signUpViewModel.defaultStates["id"] == .isValid ? .blue : .red)
            }
        }
        .onChange(of: idInput) { _ in
            //id 유효성 검사 전 입력 상태 변경
            withAnimation {
                signUpViewModel.defaultStates["id"] = .isNotVerified
            }
        }
    }
}

#Preview {
    IdInputView<SignUpViewModel>(idInput: .constant(""))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
