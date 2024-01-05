//
//  IdInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct IdInputView<SVM: SignUpVM>: View {
    @Binding var idInput: String
    @EnvironmentObject var signUpViewModel: SVM
    
    var body: some View {
        VStack {
            SignUpInputView(text: $idInput,
                            inputState: Binding(
                                get: {
                                    self.signUpViewModel.defaultStates["id"] ?? .isInitial
                                }, set: { newValue in
                                    self.signUpViewModel.defaultStates["id"] = newValue
                                }
                            ),
                            header: "아이디", placeholder: "학번 또는 교직원 번호를 입력해 주세요", keyboardType: .numberPad)
            
            //MARK: - Warning Message
            if signUpViewModel.defaultStates["id"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    Text("아이디를 입력해 주세요")
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onChange(of: idInput) { newValue in
            withAnimation {
                if newValue.isEmpty {
                    signUpViewModel.defaultStates["id"] = .isBlank
                } else {
                    signUpViewModel.defaultStates["id"] = .isValid
                }
            }
        }
    }
}

#Preview {
    IdInputView<SignUpViewModel>(idInput: .constant(""))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
