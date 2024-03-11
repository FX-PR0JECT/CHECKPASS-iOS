//
//  SearchedLectureListRow.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/26/24.
//

import SwiftUI

struct SearchedLectureListRow<T: LectureEnrollmentViewModel>: View {
    @StateObject private var viewModel: T
    
    let lecture: Lecture
    
    init(viewModel: T, lecture: Lecture) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.lecture = lecture
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 1) {
                Text(lecture.lectureName)
                    .font(.title2)
                    .bold()
                
                Text("(\(lecture.division))")
                    .font(.subheadline)
            }
            
            Text(lecture.professorName)
                .bold()
                .padding(.bottom)
            
            Text(lecture.alphaTimeCodes)
                .font(.caption)
            
            Text(lecture.lectureRoom)
                .font(.caption)
            
            HStack {
                Text("\(lecture.lectureGrade)학년")
                
                Text(lecture.lectureKind)
                
                Text("\(lecture.lectureGrades)학점")
                
                Text(String(lecture.id))
            }
            .font(.caption)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.dividerGray)
            
            HStack {
                Text("수강정원: \(lecture.lectureFull)")
                    .font(.caption)
                
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 1, height: 10)
                
                Text("현재 수강인원: \(lecture.lectureCount)")
                    .font(.caption)
                
                Spacer()
                
                Button(action: {
                    viewModel.registerLecture(for: lecture.id)
                }, label: {
                    Text("신청")
                })
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .shadow(color: Color(red: 213 / 255, green: 213 / 255, blue: 213 / 255), radius: 5, y: 3)
        }
        .alert(isPresented: $viewModel.showAlert) {            
            Alert(title: Text("알림"), message: Text(viewModel.alertMessage))
        }
    }
}

#if DEBUG
#Preview {
    SearchedLectureListRow(viewModel: AppDI.shared().getLectureEnrollmentViewModel(),
                           lecture: Lecture.sampleData)
}
#endif
