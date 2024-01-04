//
//  NameInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct NameInputView: View {
    @Binding var nameInput: String
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            SignUpInputView(text: $nameInput,
                            inputState: Binding(
                            get: {
                                self.signUpViewModel.states["name"] ?? .isInitial
                            }, set: { newValue in
                                self.signUpViewModel.states["name"] = newValue
                            }),
                            header: "이름", placeholder: "이름을 입력해 주세요")
            
            //MARK: - Warning Message
            if signUpViewModel.states["name"] == .isBlank {
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
                    signUpViewModel.states["name"] = .isBlank
                } else {
                    signUpViewModel.states["name"] = .isValid
                }
            }
        }
    }
}

#Preview {
    NameInputView(nameInput: .constant(""))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
