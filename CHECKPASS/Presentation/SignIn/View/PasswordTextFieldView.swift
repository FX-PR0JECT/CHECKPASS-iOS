//
//  PasswordTextFieldView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/25/23.
//

import SwiftUI

struct PasswordTextFieldView: View {
    @Binding var pw: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.white)
            .opacity(0.6)
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width * 0.13)
            .overlay {
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.black)
                    
                    SecureField("", text: $pw, prompt: Text("비밀번호를 입력하세요"))
                }
                .padding()
                
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color(red: 198 / 255, green: 198 / 255, blue: 198 / 255), lineWidth: 1)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width * 0.13)
            }
    }
}

#Preview {
    PasswordTextFieldView(pw: .constant(""))
}
