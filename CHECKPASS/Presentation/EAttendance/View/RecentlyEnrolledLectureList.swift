//
//  RecentlyEnrolledLectureList.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/5/24.
//

import SwiftUI

struct RecentlyEnrolledLectureList<T: RecentlyEnrolledLectureViewModel>: View {
    @ObservedObject private var viewModel: T
    
    init(viewModel: T) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            Section(header: Sectionheader(header: "수강 중인 강의")) {
                ForEach(viewModel.lectures ?? []) { lecture in
                    NavigationLink(destination: {
                        EAttendance(lecture: lecture)
                    }, label: {
                        SimpleLectureListRow(lecture)
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
        .onAppear {
            viewModel.getRecentlyEnrolledLectures()
        }
    }
}

#Preview {
    RecentlyEnrolledLectureList(viewModel: AppDI.shared().getRecentlyEnrolledLectureViewModel())
}
