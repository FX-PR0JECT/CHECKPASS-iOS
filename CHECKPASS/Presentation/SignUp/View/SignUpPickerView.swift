//
//  UserPickerView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

import SwiftUI

struct SignUpPickerView: View {
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @Binding var selection: String
    @Environment(\.colorScheme) private var colorScheme
    
    var header: String
    var title: String
    var contents: [String]
    var pos: String
    
    var body: some View {
        VStack {
            HStack {
                Text(header).bold().font(.subheadline).foregroundColor(colorScheme == .light ? .black : .white)
                
                Spacer()
            }
            .offset(x: 16)
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(CustomColor.getSignUpInputGray(colorScheme))
                    .frame(height: UIScreen.main.bounds.width * 0.13)
                
                HStack {
                    Text(title)
                    
                    Spacer()
                    
                    Picker(title, selection: $selection) {
                        ForEach(contents, id: \.self) { content in
                            Text(content)
                        }
                    }
                }
                .padding([.trailing, .leading])
            }
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(signUpViewModel.states[pos] == .isValid || signUpViewModel.states[pos] == .isInitial ? CustomColor.getSignUpInputGray(colorScheme) : .red, lineWidth: 1)
                    .frame(height: UIScreen.main.bounds.width * 0.13)
            }
            
            if signUpViewModel.states[pos] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    Text("\(header)(을)를 입력해 주세요")
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onChange(of: selection) { newValue in
            withAnimation {
                if newValue == "선택" {
                    signUpViewModel.states[pos] = .isBlank
                } else {
                    signUpViewModel.states[pos] = .isValid
                }
            }
        }
    }
}

#Preview {
    SignUpPickerView(selection: .constant(""), header: "header", title: "title", contents: ["선택", "학생", "교수", "교직원"], pos: "type")
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
