//
//  LectureDetail.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/29/24.
//

import SwiftUI

struct LectureDetail: View {
    private let lecture: Lecture
    
    init(lecture: Lecture) {
        self.lecture = lecture
    }
    
    var body: some View {
        List {
            Section(header: Text("강의정보").font(.title3).bold().foregroundColor(.black)) {
                LectureInfoListRow(imageName: "square.fill.and.line.vertical.and.square.fill",
                                   title: "분반",
                                   content: lecture.division)
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return 0
                }
                
                LectureInfoListRow(imageName: "person.fill",
                                   title: "교수명",
                                   content: "\(lecture.professorName) 교수님")
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return 0
                }
                
                LectureInfoListRow(imageName: "clock.fill",
                                   title: "강의 시간",
                                   content: lecture.alphaTimeCodes)
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return 0
                }
                
                LectureInfoListRow(imageName: "building.columns.fill",
                                   title: "강의실",
                                   content: lecture.lectureRoom)
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return 0
                }
                
                LectureInfoListRow(imageName: "info.circle.fill",
                                   title: "이수구분",
                                   content: lecture.lectureKind)
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return 0
                }
                
                LectureInfoListRow(imageName: "graduationcap.fill",
                                   title: "학점",
                                   content: "\(lecture.lectureGrades)학점")
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return 0
                }
                
                LectureInfoListRow(imageName: "person.2.fill",
                                   title: "수강인원",
                                   content: "\(lecture.lectureCount)명")
            }
            .listSectionSeparator(.hidden)
            
            AttendanceStatusView(lectureId: lecture.id,
                                 viewModel: AppDI.shared().getAttendanceStatusViewModel())
                .listRowSeparator(.hidden)
                .padding(.top)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(lecture.lectureName)
    }
}

#if DEBUG
#Preview {
    LectureDetail(lecture: Lecture.sampleData)
}
#endif
