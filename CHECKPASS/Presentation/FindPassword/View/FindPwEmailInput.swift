//
//  EmailInputForFindPw.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/2/24.
//

import SwiftUI

struct FindPwEmailInput: View {
    @Binding var text: String
    @Binding var inputState: InputStatus
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isFocused: Bool?
    
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack {            
            RoundedRectangle(cornerRadius: 30)
                .fill(CustomColor.getSignUpInputGray(colorScheme))
                .frame(height: UIScreen.main.bounds.width * 0.13)
                .overlay {
                    TextField(placeholder, text: $text)
                        .keyboardType(keyboardType)
                        .autocorrectionDisabled()
                        .focused($isFocused, equals: true)
                        .padding()
                    
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(inputState == .isValid || inputState == .isInitial ? CustomColor.getSignUpInputGray(colorScheme) : .red, lineWidth: 1)
                        .frame(height: UIScreen.main.bounds.width * 0.13)
                }
            
            //MARK: - Warning Message
            if inputState == .isInvalid || inputState == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    if inputState == .isInvalid {
                        Text("이메일 형식이 올바르지 않아요")
                    } else if inputState == .isBlank {
                        Text("이메일을 입력해 주세요")
                    }
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onAppear {
            isFocused = true
        }
        .onChange(of: text) { newValue in
            if newValue.isEmpty {
                inputState = .isBlank
            } else {
                
            }
        }
    }
}

#Preview {
    FindPwEmailInput(text: .constant(""), inputState: .constant(.isInitial), placeholder: "이메일을 입력하세요")
}
