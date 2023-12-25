//
//  SignInView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/22/23.
//

import SwiftUI

struct SignInView: View {
    @State private var id: String = ""
    @State private var pw: String = ""
    
    var body: some View {
        VStack(spacing: 15) {
            //MARK: Id input TextField
            IdTextFieldView(id: $id)
            
            //MARK: - Password input TextField
            PasswordTextFieldView(pw: $pw)
            
            //MARK: - Sign In Button
            Button(action: {}, label: {
                Text("로그인")
                    .padding(.all, 15)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(30)
            })
            
            HStack(spacing: 15) {
                //MARK: - Create new account Button
                Button(action: {}, label: {
                    Text("새 계정 만들기")
                        .foregroundColor(.gray)
                })
                
                //MARK: - Contour
                Rectangle()
                    .fill(Color(red: 164 / 255, green: 164 / 255, blue: 167 / 255))
                    .frame(width: 2, height: 20)
                
                //MARK: - Find Password Button
                Button(action: {}, label: {
                    Text("비밀번호 찾기")
                        .foregroundColor(.gray)
                })
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    SignInView()
}
