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
            HStack {
                Text("출석현황")
                    .bold()
                    .font(.title3)
                
                Spacer()
            }
            
            ForEach(0..<2) { i in
                HStack {
                    ForEach(0..<8) { j in
                        SingleWeek(week: j + 8 * i + 1,
                                   firstStatus: viewModel.attendanceStatus?[j + 8 * i].firstStatus,
                                   secondStatus: viewModel.attendanceStatus?[j + 8 * i].secondStatus)
                    }
                }
            }
            .padding(.bottom, 8)
            
            AttendanceLegend(pos: .trailing)
        }
        .onAppear {
            viewModel.fetchStatus(for: lectureId)
        }
    }
}

#if DEBUG
#Preview {
    AttendanceStatusView(lectureId: Lecture.sampleData.id,
                         viewModel: AppDI.shared().getAttendanceStatusViewModel())
}
#endif
