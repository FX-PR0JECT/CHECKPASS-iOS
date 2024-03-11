//
//  MyLectureListRow.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/1/24.
//

import SwiftUI

struct SimpleLectureListRow: View {
    enum IconType {
        case structure
        case radio
    }
    
    private let lecture: Lecture
    private let iconType: IconType
    
    init(_ lecture: Lecture, for attendanceType: IconType) {
        self.lecture = lecture
        self.iconType = attendanceType
    }
    
    var body: some View {
        HStack(spacing: 10) {
            switch iconType {
            case .structure:
                LectureIcon()
            case .radio:
                BeaconIcon()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(lecture.lectureName)(\(lecture.division))")
                    .font(.headline)
                
                HStack(spacing: 6) {
                    Text(lecture.professorName)
                    
                    Text(lecture.lectureRoom)
                    
                    Spacer()
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
        }
    }
}

#if DEBUG
#Preview {
    SimpleLectureListRow(Lecture.sampleData, 
                         for: .radio)
}
#endif
