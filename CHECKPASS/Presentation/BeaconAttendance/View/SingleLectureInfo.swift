//
//  SingleLectureInfo.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/29/24.
//

import SwiftUI

struct SingleLectureInfo: View {
    let image: String
    let title: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            Image(systemName: image)
            
            Text(title)
        }
        .font(.footnote)
    }
}

#Preview {
    SingleLectureInfo(image: "person.fill", title: "홍길동 교수님")
}
