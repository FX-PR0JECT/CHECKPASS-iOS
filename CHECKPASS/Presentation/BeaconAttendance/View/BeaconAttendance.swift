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
        if viewModel.result != nil {
            AttendanceResult<T>()
                .environmentObject(viewModel)
                .toolbar(.hidden, for: .tabBar)
        } else {
            ZStack {
                if viewModel.isProgress {
                    CustomProgressView()
                }
                
                List {
                    LectureInfo(lecture: lecture,
                                spacing: 13)
                    .foregroundColor(.gray)
                    .listRowSeparator(.hidden)
                    
                    Divider()
                        .listRowSeparator(.hidden)
                    
                    Button(action: {
                        if let viewModel = viewModel as? BeaconAttendanceViewModel {
                            viewModel.attend(lectureId: lecture.id)
                        }
                    }, label: {
                        BeaconAttendanceButtonLabel()
                    })
                    .buttonStyle(.borderless)
                    .listRowSeparator(.hidden)
                    
                    CurrentTimeView()
                        .listRowSeparator(.hidden)
                    
                    Divider()
                        .listRowSeparator(.hidden)
                    
                    AttendanceStatusView(lectureId: lecture.id,
                                         viewModel: AppDI.shared().getAttendanceStatusViewModel())
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle(lecture.lectureName)
            }
        }
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
