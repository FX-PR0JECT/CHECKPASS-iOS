//
//  BeaconAttendanceList.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/5/24.
//

import SwiftUI

struct BeaconAttendanceList: View {
    var body: some View {
        #if DEBUG
        List {
            Section(header: Sectionheader(header: "근처 강의실")) {
                ForEach([Lecture.sampleData]) { lecture in
                    NavigationLink(destination: {
                        BeaconAttendance(lecture: lecture)
                    }, label: {
                        SimpleLectureListRow(lecture, for: .radio)
                            .padding([.top, .bottom])
                    })
                    .listRowSeparator(.hidden)
                }
                .listSectionSeparator(.visible, edges: .top)
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("비콘출석")
        #else
        #endif
    }
}

#Preview {
    BeaconAttendanceList()
}
