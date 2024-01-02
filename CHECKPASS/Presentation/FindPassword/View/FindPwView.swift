//
//  findPasswordView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/29/23.
//

import SwiftUI

struct FindPwView: View {
    @State private var emailInput: String = ""
    @State private var inputStatus: InputStatus = .isInitial
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "lock.circle")
                .font(.largeTitle)
            
            Text("비밀번호를 잊으셨나요?")
                .bold()
                .font(.title)
            
            Text("비밀번호 재설정을 위해 이메일로 인증번호를 보내드립니다")
                .multilineTextAlignment(.center)
            
            FindPwEmailInput(text: $emailInput, inputState: $inputStatus, placeholder: "이메일을 입력하세요", keyboardType: .emailAddress)
            
            Spacer()
            
            if inputStatus != .isValid {
                Button(action: {}, label: {
                    Text("다음")
                        .bold()
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(30)
                })
                .disabled(true)
            } else {
                Button(action: {}, label: {
                    Text("다음")
                        .bold()
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(30)
                })
            }
            
        }
        .padding()
    }
}

#Preview {
    FindPwView()
}
