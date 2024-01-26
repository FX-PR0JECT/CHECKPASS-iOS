//
//  ShortcutsView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/25/24.
//

import SwiftUI

struct ShortcutsView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: UIScreen.main.bounds.width * 0.2)
                .foregroundColor(.white)
                .shadow(radius: 2)
            
            HStack(spacing: 50) {
                NavigationLink(destination: {}, label: {
                    ShortcutIcon(image: "rocket", caption: "홈페이지")
                        .foregroundColor(.black)
                })
                
                NavigationLink(destination: {}, label: {
                    ShortcutIcon(image: "calender", caption: "학사일정")
                        .foregroundColor(.black)
                })
                
                NavigationLink(destination: {}, label: {
                    ShortcutIcon(image: "megaphone", caption: "학사공지")
                        .foregroundColor(.black)
                })
                
                NavigationLink(destination: {}, label: {
                    ShortcutIcon(image: "puzzle", caption: "통합정보")
                        .foregroundColor(.black)
                })
            }
        }
    }
}

#Preview {
    ShortcutsView()
}
