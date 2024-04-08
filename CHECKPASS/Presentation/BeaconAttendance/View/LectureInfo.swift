//
//  LectureInfo.swift
//  CHECKPASS
//
//  Created by 이정훈 on 4/5/24.
//

import SwiftUI

struct LectureInfo: View {
    let lecture: Lecture
    let spacing: CGFloat
    
    var body: some View {
        VStack(spacing: spacing) {
            HStack {
                VStack(alignment: .leading, spacing: spacing) {
                    SingleLectureInfo(image: "person.fill", title: "\(lecture.professorName) 교수님")
                    
                    SingleLectureInfo(image: "info.circle.fill", title: lecture.lectureKind)
                }
                .padding(.trailing, 50)
                
                VStack(alignment: .leading, spacing: spacing) {
                    SingleLectureInfo(image: "building.columns.fill", title: lecture.lectureRoom)
                    
                    SingleLectureInfo(image: "graduationcap.fill", title: "\(lecture.lectureGrades)학점")
                }
                
                Spacer()
            }
            
            HStack {
                SingleLectureInfo(image: "clock.fill", title: lecture.alphaTimeCodes)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LectureInfo(lecture: Lecture.sampleData,
                      spacing: 10)
}
