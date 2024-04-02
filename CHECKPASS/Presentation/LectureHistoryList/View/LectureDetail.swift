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
            HStack(spacing: 3) {
                Text(lecture.lectureName)
                    .font(.title)
                    .bold()
                
                Text("(\(lecture.division))")
            }
            .listRowSeparator(.hidden)
            
            VStack(alignment: .leading) {
                Text("강의 정보")
                    .font(.title3)
                    .bold()
                
                GroupBox {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 20) {
                                LectureInfo(image: "person.circle.fill",
                                            title: "\(lecture.professorName) 교수님")
                                
                                LectureInfo(image: "info.circle.fill",
                                            title: lecture.lectureKind)
                            }
                            .padding(.trailing)
                            
                            VStack(alignment: .leading, spacing: 20) {
                                LectureInfo(image: "building.columns.fill",
                                            title: lecture.lectureRoom)
                                
                                LectureInfo(image: "graduationcap.fill",
                                            title: "\(lecture.lectureGrades)학점")
                            }
                        }
                        
                        HStack(spacing: 50) {
                            LectureInfo(image: "clock.fill",
                                        title: lecture.alphaTimeCodes)
                            
                            Spacer()
                        }
                    }
                    .padding([.top, .bottom])
                }
            }
            
            AttendanceStatusView(lectureId: lecture.id,
                                 viewModel: AppDI.shared().getAttendanceStatusViewModel())
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("강의정보")
    }
}

#if DEBUG
#Preview {
    LectureDetail(lecture: Lecture.sampleData)
}
#endif
