//
//  SignUpView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

import SwiftUI

struct SignUpView: View {  
    @State private var idInput: String = ""
    @State private var pwInput: String = ""
    @State private var pwConfirmationInput: String = ""
    @State private var nameInput: String = ""
    @State private var emailInput: String = ""
    @State private var pickedType: String = ""
    @State private var pickedCollege: String = "단과대"
    @State private var pickedDepartment: String = ""
    
    var body: some View {        
        ScrollView {
            VStack(spacing: 30) {
                SignUpInputView(text: $idInput, header: "아이디", placeholder: "학번 또는 교직원 번호를 입력해 주세요", keyboardType: .numberPad)
                
                SignUpInputView(text: $pwInput, header: "비밀번호", placeholder: "비밀번호를 입력해 주세요", style: .secure)
                
                SignUpInputView(text: $pwConfirmationInput, header: "비밀번호 확인", placeholder: "비밀번호를 다시 한번 입력해 주세요", style: .secure)
                
                SignUpInputView(text: $nameInput, header: "이름", placeholder: "이름을 입력해 주세요")
                
                SignUpInputView(text: $emailInput, header: "이메일", placeholder: "이메일을 입력해 주세요", keyboardType: .URL)
                
                SignUpPickerView(selection: $pickedType, header: "구분", title: "구분을 선택해 주세요", contents: PickerContents.userTypes)
                
                SignUpPickerView(selection: $pickedCollege, header: "단과대", title: "단과대를 선택해 주세요", contents: PickerContents.colleges)
                
                SignUpPickerView(selection: $pickedDepartment, header: "학과", title: "학과를 선택해 주세요", contents: PickerContents.departments[pickedCollege]!)
                
                Button(action: {}, label: {
                    Text("회원가입")
                        .bold()
                        .padding(.all, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(30)
                    
                })
            }
            .padding()
        }
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    SignUpView()
}
