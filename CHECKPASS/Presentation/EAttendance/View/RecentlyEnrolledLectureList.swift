//
//  RecentlyEnrolledLectureList.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/5/24.
//

import SwiftUI

struct RecentlyEnrolledLectureList<T: RecentlyEnrolledLectureViewModel>: View {
    @EnvironmentObject private var viewModel: T
    
    var body: some View {
        if let lectures = viewModel.lectures {
            List {
                Section(header: Sectionheader(header: "수강 중인 강의")) {
                    ForEach(lectures) { lecture in
                        NavigationLink(destination: {
                            EAttendance(lecture: lecture)
                        }, label: {
                            SimpleLectureListRow(lecture,
                                                 for: .structure)
                            .padding([.top, .bottom])
                        })
                        .listRowSeparator(.hidden)
                    }
                    .listSectionSeparator(.visible, edges: .top)
                }
            }
            .listStyle(.plain)
            .navigationTitle("전자출결")
            .navigationBarTitleDisplayMode(.large)
        } else {
            NoLectureView()
                .navigationTitle("전자출결")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    RecentlyEnrolledLectureList<DefaultRecentlyEnrolledLectureViewModel>()
        .environmentObject(AppDI.shared().getRecentlyEnrolledLectureViewModel())
}
