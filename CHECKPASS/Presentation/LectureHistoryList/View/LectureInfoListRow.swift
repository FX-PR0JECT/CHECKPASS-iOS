//
//  LectureInfoListRow.swift
//  CHECKPASS
//
//  Created by 이정훈 on 4/5/24.
//

import SwiftUI

struct LectureInfoListRow: View {
    let imageName: String
    let title: String
    let content: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            
            Text(title)
            
            Spacer()
            
            Text(content)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
        .padding([.top, .bottom], 10)
    }
}

#Preview {
    LectureInfoListRow(imageName: "person.fill",
                       title: "교수명",
                       content:"홍길동")
}
