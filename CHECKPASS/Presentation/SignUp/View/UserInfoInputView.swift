//
//  InputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

import SwiftUI

enum TextFieldStyle {
    case normal
    case secure
}

struct UserInfoInputView: View {
    @Binding private var text: String
    @Binding private var inputState: InputState
    @Environment(\.colorScheme) private var colorScheme
    
    var header: String
    var placeholder: String
    var style: TextFieldStyle
    var keyboardType: UIKeyboardType
    
    init(text: Binding<String>, inputState: Binding<InputState>,
         header: String, placeholder: String, style: TextFieldStyle = .normal,
         keyboardType: UIKeyboardType = .default) {
        _text = text
        _inputState = inputState
        self.header = header
        self.placeholder = placeholder
        self.style = style
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(header).bold().font(.subheadline).foregroundColor(colorScheme == .light ? .black : .white)
                
                Spacer()
            }
            .offset(x: 16)
            
            RoundedRectangle(cornerRadius: 30)
                .fill(.userInfoInputGray)
                .frame(height: UIScreen.main.bounds.width * 0.13)
                .overlay {
                    switch style {
                    case .normal:
                        TextField(placeholder, text: $text)
                            .keyboardType(keyboardType)
                            .autocorrectionDisabled()
                            .padding()
                    case .secure:
                        SecureField(placeholder, text: $text)
                            .keyboardType(keyboardType)
                            .textContentType(.newPassword)
                            .padding()
                    }
                    
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(inputState == .isValid || inputState == .isInitial || inputState == .isNotVerified ? .userInfoInputGray : .red, lineWidth: 1)
                        .frame(height: UIScreen.main.bounds.width * 0.13)
                }
        }
    }
}

#Preview {
    UserInfoInputView(text: .constant(""), inputState: .constant(.isInitial), header: "header", placeholder: "placeholder", style: .normal)
}
