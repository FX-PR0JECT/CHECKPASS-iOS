//
//  IdInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct IdInputView: View {
    @Binding var idInput: String
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            SignUpInputView(text: $idInput, inputStatus: $signUpViewModel.statuses[0], header: "아이디", placeholder: "학번 또는 교직원 번호를 입력해 주세요", keyboardType: .numberPad)
            
            //MARK: - Warning Message
            if signUpViewModel.statuses[0] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    Text("아이디를 입력해 주세요")
                    
                    Spacer()
                }
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onChange(of: idInput) { newValue in
            if newValue.isEmpty {
                signUpViewModel.statuses[0] = .isBlank
            } else {
                signUpViewModel.statuses[0] = .isValid
            }
        }
    }
}

#Preview {
    IdInputView(idInput: .constant(""))
        .environmentObject(SignUpViewModel())
}
