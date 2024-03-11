//
//  LectureIcon.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/29/24.
//

import SwiftUI

struct LectureIcon: View {
    var body: some View {        
        Circle()
            .fill(.lectureBackground)
            .frame(width: 50, height: 50)
            .overlay {
                Image(systemName: "building.columns.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25)
                    .foregroundColor(.white)
            }
    }
}

#Preview {
    LectureIcon()
}
