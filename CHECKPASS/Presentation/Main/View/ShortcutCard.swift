//
//  ShortcutCard.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/23/24.
//

import SwiftUI

enum Shortcuts: String {
    case homepage = "홈페이지"
    case schedule = "학사일정"
    case notice = "학사공지"
    case system = "통합정보"
}

struct ShortcutCard: View {
    private var text: String
    private var background: Color
    private var textColor: Color
    private var imageName: String
    
    init(for text: Shortcuts, background: Color, textColor: Color, imageName: String) {
        self.text = text.rawValue
        self.background = background
        self.textColor = textColor
        self.imageName = imageName
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width * 0.27,
                       height: UIScreen.main.bounds.width * 0.27)
                .foregroundColor(background)
                .shadow(color: Color(red: 213 / 255, green: 213 / 255, blue: 213 / 255), radius: 5, y: 3)
                .overlay {
                    VStack {
                        HStack {
                            Text(text)
                                .foregroundColor(textColor)
                                .fontWeight(.black)
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.2)
                            .offset(x: 20, y: 10)
                        
                    }
                    .padding()
                }
        }
    }
}

#Preview {
    ShortcutCard(for: .homepage,
                 background: Color(red: 249 / 255, green: 136 / 255, blue: 102 / 255),
                 textColor: Color(red: 255 / 255, green: 242 / 255, blue: 215 / 255),
                 imageName: "rocket")
}
