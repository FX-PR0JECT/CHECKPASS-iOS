//
//  MyLectureListRow.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/1/24.
//

import SwiftUI

struct SimpleLectureListRow: View {
    private let lecture: SimpleLecture
    
    init(_ lecture: SimpleLecture) {
        self.lecture = lecture
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(lecture.name)(\(lecture.division))")
                .font(.headline)
            
            HStack {
                Text(lecture.professor)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
        }
    }
}

#if DEBUG
#Preview {
    SimpleLectureListRow(SimpleLecture(id: "123456", name: "객체지향설계", professor: "홍길동", division: "1분반"))
}
#endif
