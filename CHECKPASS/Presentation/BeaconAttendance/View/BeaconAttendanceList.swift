//
//  BeaconAttendanceList.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/5/24.
//

import SwiftUI

struct BeaconAttendanceList<T: AttendanceViewModel>: View {
    @ObservedObject private var viewModel: T
    
    init(viewModel: T) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    var body: some View {
        List {
            Section(header: Sectionheader(header: "근처 강의실")) {
                #if DEBUG
                ForEach([Lecture.sampleData]) { lecture in
                    NavigationLink(destination: {
                        BeaconAttendance<T>(lecture: lecture)
                            .environmentObject(viewModel)
                    }, label: {
                        SimpleLectureListRow(lecture, for: .radio)
                            .padding([.top, .bottom])
                    })
                    .listRowSeparator(.hidden)
                }
                .listSectionSeparator(.visible, edges: .top)
                #else
                if let viewModel = viewModel as? BeaconAttendanceViewModel,
                   let lectures = viewModel.lectures {
                    ForEach(lectures) { lecture in
                        NavigationLink(destination: {
                            BeaconAttendance<T>(lecture: lecture)
                                .environmentObject(self.viewModel)
                        }, label: {
                            SimpleLectureListRow(lecture, for: .radio)
                                .padding([.top, .bottom])
                        })
                        .listRowSeparator(.hidden)
                    }
                    .listSectionSeparator(.visible, edges: .top)
                }
                #endif
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("비콘출석")
        .onAppear {
            if let viewModel = viewModel as? BeaconAttendanceViewModel {
                viewModel.startScan()
            }
        }
    }
}

#Preview {
    BeaconAttendanceList<DefaultBeaconAttendanceViewModel>(viewModel: AppDI.shared().getBeaconAttendanceViewModel())
        .environmentObject(AppDI.shared().getBeaconAttendanceViewModel())
}
