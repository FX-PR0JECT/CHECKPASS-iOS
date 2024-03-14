//
//  TimeTable.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/12/24.
//

import SwiftUI

struct TimeTable<T: RecentlyEnrolledLectureViewModel>: View {
    @EnvironmentObject private var viewModel: T
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                TimeTableGrid()
                
                #if DEBUG
                ForEach(0..<Lecture.sampleDataArray.count, id: \.self) { idx in
                    ForEach(Array(Lecture.sampleDataArray[idx].scheduleArray.keys), id: \.self) { key in
                        if let xCoordinate = xCoordinate(of: key) {
                           TimeTableBlock(lectureIndex: idx,
                                          xCoordinate: xCoordinate,
                                          title: Lecture.sampleDataArray[idx].lectureName,
                           scheduleArray: Lecture.sampleDataArray[idx].scheduleArray[key])
                       }
                    }
                }
                #else
                if let lectures = viewModel.lectures {
                    ForEach(0..<lectures.count, id: \.self) { idx in
                        ForEach(Array(lectures[idx].scheduleArray.keys), id: \.self) { key in
                            if let xCoordinate = xCoordinate(of: key) {
                                TimeTableBlock(lectureIndex: idx, xCoordinate: xCoordinate, title: lectures[idx].lectureName, scheduleArray: lectures[idx].scheduleArray[key])
                            }
                        }
                    }
                }
                #endif
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("시간표")
    }
}

extension TimeTable {
    private func xCoordinate(of week: String) -> Int? {
        return dayOfWeek.firstIndex(of: week)
    }
}

#Preview {
    TimeTable<DefaultRecentlyEnrolledLectureViewModel>()
        .environmentObject(AppDI.shared().getRecentlyEnrolledLectureViewModel())
}
