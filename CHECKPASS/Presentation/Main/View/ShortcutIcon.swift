//
//  ShortcutIcon.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/25/24.
//

import SwiftUI

struct ShortcutIcon: View {
    let image: String
    let caption: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
            
            Text(caption)
                .font(.caption2)
        }
    }
}

#Preview {
    ShortcutIcon(image: "calender", caption: "홈페이지")
}
