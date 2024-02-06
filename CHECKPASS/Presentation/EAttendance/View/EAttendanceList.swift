//
//  EAttendanceList.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/5/24.
//

import SwiftUI

struct EAttendanceList: View {
    #if DEBUG
    @State private var lectures: [SimpleLecture] = SimpleLecture.sampleData["2024학년도 1학기"] ?? []
    #else
    #endif
    
    var body: some View {
        List {
            #if DEBUG
            Section(header: Sectionheader(header: "2024학년도 1학기")) {
                ForEach(lectures) { lecture in
                    NavigationLink(destination: {
                        EAttendance(lecture: lecture)
                    }, label: {
                        SimpleLectureListRow(lecture)
                    })
                }
            }
            #else
            #endif
        }
        .navigationTitle("전자출석")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    EAttendanceList()
}
