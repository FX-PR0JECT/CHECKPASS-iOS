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

struct SignUpInputView: View {
    @Binding var text: String
    @Environment(\.colorScheme) private var colorScheme
    
    var header: String
    var placeholder: String
    var style: TextFieldStyle = .normal
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack {
            HStack {
                Text(header).bold().font(.subheadline).foregroundColor(colorScheme == .light ? .black : .white)
                
                Spacer()
            }
            .offset(x: 16)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 198 / 255, green: 198 / 255, blue: 198 / 255))
                .opacity(0.2)
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
                            .padding()
                    }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 198 / 255, green: 198 / 255, blue: 198 / 255), lineWidth: 1)
                        .opacity(0.2)
                        .frame(height: UIScreen.main.bounds.width * 0.13)
                }
        }
    }
}

#Preview {
    SignUpInputView(text: .constant(""), header: "header", placeholder: "placeholder", style: .normal)
}
