//
//  BeaconAttendance.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/11/24.
//

import SwiftUI

struct BeaconAttendance<T: AttendanceViewModel>: View {
    @EnvironmentObject private var viewModel: T
    
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
            }
            .padding(.bottom, 30)
            
            Button(action: {
                if let viewModel = viewModel as? BeaconAttendanceViewModel {
                    viewModel.attend(lectureId: lecture.id)
                }
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
        .navigationTitle("비콘출석")
    }
}

#if DEBUG
#Preview {
    BeaconAttendance<DefaultBeaconAttendanceViewModel>(
        lecture: Lecture.sampleData
    )
    .environmentObject(AppDI.shared().getBeaconAttendanceViewModel())
}
#endif
