//
//  CodeInput.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/5/24.
//

import SwiftUI

struct CodeInput: View {
    @Binding private var input: String
    
    private let index: Int
    
    init(input: Binding<String>, index: Int) {
        _input = input
        self.index = index
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 13)
            .stroke(Color(red: 198 / 255, green: 198 / 255, blue: 198 / 255), lineWidth: 3)
            .frame(width: UIScreen.main.bounds.width * 0.13,
                   height: UIScreen.main.bounds.width * 0.15)
            .overlay {
                Text(getSpecificChars(input, pos: index))
                    .font(.title2)
                    .bold()
            }
    }
}

extension CodeInput {
    func getSpecificChars(_ value: String, pos: Int) -> String {
        guard value.count > pos else {
            return ""
        }
        
        let i = value.index(value.startIndex, offsetBy: pos)
        return String(value[i])
    }
}

#Preview {
    CodeInput(input: .constant("hello"), index: 0)
}
