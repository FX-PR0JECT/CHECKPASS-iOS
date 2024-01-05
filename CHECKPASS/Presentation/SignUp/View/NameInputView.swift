//
//  NameInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct NameInputView<SVM: SignUpVM>: View {
    @Binding var nameInput: String
    @EnvironmentObject var signUpViewModel: SVM
    
    var body: some View {
        VStack {
            SignUpInputView(text: $nameInput,
                            inputState: Binding(
                            get: {
                                self.signUpViewModel.defaultStates["name"] ?? .isInitial
                            }, set: { newValue in
                                self.signUpViewModel.defaultStates["name"] = newValue
                            }),
                            header: "이름", placeholder: "이름을 입력해 주세요")
            
            //MARK: - Warning Message
            if signUpViewModel.defaultStates["name"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    Text("이름을 입력해 주세요")
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onChange(of: nameInput) { newValue in
            withAnimation {
                if nameInput.isEmpty {
                    signUpViewModel.defaultStates["name"] = .isBlank
                } else {
                    signUpViewModel.defaultStates["name"] = .isValid
                }
            }
        }
    }
}

#Preview {
    NameInputView<SignUpViewModel>(nameInput: .constant(""))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
