//
//  BeaconAttendance.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/11/24.
//

import SwiftUI

struct BeaconAttendance: View {
    private let lecture: Lecture
    
    init(lecture: Lecture) {
        self.lecture = lecture
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(lecture.lectureName)
                    .font(.largeTitle)
                    .bold()
                
                Text("(\(lecture.division))")
                
                Spacer()
            }
            .padding(.bottom, 10)
            
            Text(lecture.alphaTimeCodes)
                .foregroundColor(.gray)
                .font(.footnote)
            
            HStack {
                Image(systemName: "mappin.and.ellipse")
                
                Text(lecture.lectureRoom)
                
                Spacer()
                
                Text("\(lecture.professorName) 교수님")
            }
            .foregroundColor(.gray)
            .font(.footnote)
            
            Divider()
                .padding(.bottom)
            
            Button(action: {
                
            }, label: {
                BeaconAttendanceButtonLabel()
            })
            
            CurrentTimeView()
                .padding()
            
            Divider()
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
#Preview {
    BeaconAttendance(lecture: Lecture.sampleData)
}
#endif
