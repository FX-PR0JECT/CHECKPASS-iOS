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
            SignUpInputView(text: $nameInput, inputState: $signUpViewModel.states[3], header: "이름", placeholder: "이름을 입력해 주세요")
            
            //MARK: - Warning Message
            if signUpViewModel.states[3] == .isBlank {
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
                    signUpViewModel.states[3] = .isBlank
                } else {
                    signUpViewModel.states[3] = .isValid
                }
            }
        }
    }
}

#Preview {
    NameInputView(nameInput: .constant(""))
        .environmentObject(SignUpViewModel())
}
