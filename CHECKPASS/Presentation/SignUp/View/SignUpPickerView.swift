//
//  UserPickerView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

import SwiftUI

struct SignUpPickerView: View {
    @Binding var selection: String
    @Environment(\.colorScheme) private var colorScheme
    
    var header: String
    var title: String
    var contents: [String]
    
    var body: some View {
        VStack {
            HStack {
                Text(header).bold().font(.subheadline).foregroundColor(colorScheme == .light ? .black : .white)
                
                Spacer()
            }
            .offset(x: 16)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 198 / 255, green: 198 / 255, blue: 198 / 255))
                    .opacity(0.2)
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
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 198 / 255, green: 198 / 255, blue: 198 / 255), lineWidth: 1)
                    .opacity(0.2)
                    .frame(height: UIScreen.main.bounds.width * 0.13)
            }
        }
    }
}

#Preview {
    SignUpPickerView(selection: .constant(""), header: "header", title: "title", contents: ["선택", "학생", "교수", "교직원"])
}
