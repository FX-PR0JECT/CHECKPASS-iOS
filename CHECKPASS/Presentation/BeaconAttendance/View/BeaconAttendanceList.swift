//
//  BeaconAttendanceList.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/5/24.
//

import SwiftUI

struct BeaconAttendanceList<T: AttendanceViewModel>: View {
    @ObservedObject private var viewModel: T
    @EnvironmentObject private var userInfoViewModel: UserInfoViewModel
    
    init(viewModel: T) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    var body: some View {
        if let beaconAttendanceViewModel = viewModel as? BeaconAttendanceViewModel,
           let lectures = beaconAttendanceViewModel.lectures {
            List {
                Section(header: Sectionheader(header: "근처 강의실")) {
                    #if DEBUG
                    ForEach([Lecture.sampleData]) { lecture in
                        NavigationLink(destination: {
                            BeaconAttendance<T>(lecture: lecture)
                                .environmentObject(viewModel)
                                .environmentObject(self.userInfoViewModel)
                        }, label: {
                            SimpleLectureListRow(lecture, for: .radio)
                                .padding([.top, .bottom])
                        })
                        .listRowSeparator(.hidden)
                    }
                    .listSectionSeparator(.visible, edges: .top)
                    #else
                    ForEach(lectures) { lecture in
                        NavigationLink(destination: {
                            BeaconAttendance<T>(lecture: lecture)
                                .environmentObject(self.viewModel)
                                .environmentObject(self.userInfoViewModel)
                        }, label: {
                            SimpleLectureListRow(lecture, for: .radio)
                                .padding([.top, .bottom])
                        })
                        .listRowSeparator(.hidden)
                    }
                    .listSectionSeparator(.visible, edges: .top)
                    #endif
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("비콘출석")
        } else {
            Image("SearchingBeacons")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.6)
                .onAppear {
                    if let viewModel = viewModel as? BeaconAttendanceViewModel {
                        viewModel.startScan()
                    }
                }
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("비콘출석")
        }
    }
}

#Preview {
    BeaconAttendanceList<DefaultBeaconAttendanceViewModel>(viewModel: AppDI.shared().getBeaconAttendanceViewModel())
        .environmentObject(AppDI.shared().getBeaconAttendanceViewModel())
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
