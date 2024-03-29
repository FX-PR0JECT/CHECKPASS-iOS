//
//  AttendanceStatusView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/25/24.
//

import SwiftUI

struct AttendanceStatusView<T: AttendanceStatusViewModel>: View {
    @StateObject private var viewModel: T
    
    private let lectureId: Int
    
    init(lectureId: Int, viewModel: T) {
        self.lectureId = lectureId
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            ForEach(0..<2) { i in
                HStack {
                    ForEach(0..<8) { j in
                        SingleWeek(week: j + 8 * i + 1,
                                   firstStatus: viewModel.attendanceStatus?[j + 8 * i].firstStatus,
                                   secondStatus: viewModel.attendanceStatus?[j + 8 * i].secondStatus)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchStatus(for: lectureId)
        }
    }
}

#Preview {
    AttendanceStatusView(lectureId: Lecture.sampleData.id,
                         viewModel: AppDI.shared().getAttendanceStatusViewModel())
}
