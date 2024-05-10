//
//  BeaconAttendance.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/11/24.
//

import SwiftUI

struct BeaconAttendance<T: AttendanceViewModel>: View {
    @EnvironmentObject private var viewModel: T
    @EnvironmentObject private var userInfoViewModel: UserInfoViewModel
    
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
                
                Color(red: 45 / 255, green: 45 / 255, blue: 47 / 255)
                    .ignoresSafeArea()
                
                VStack {
                    BeaconAttendanceUserInfo(lecture: lecture)
                        .padding([.leading, .trailing], 30)
                    
                    CurrentTimeView()
                        .padding(15)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        if let viewModel = viewModel as? BeaconAttendanceViewModel {
                            viewModel.attend(lectureId: lecture.id)
                        }
                    }, label: {
                        Text("출석하기")
                            .bold()
                            .padding(8)
                            .frame(maxWidth: .infinity)
                    })
                    .tint(Color(red: 47 / 255, green: 83 / 255, blue: 154 / 255))
                    .buttonBorderShape(.roundedRectangle)
                    .cornerRadius(30)
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .onAppear {
                    if userInfoViewModel.detailedUserInfo == nil {
                        userInfoViewModel.getDetailedUserInfo()
                    }
                }
                .toolbar(.hidden, for: .tabBar)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("비콘 출석")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
//                .navigationBarHidden(true)
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
    .environmentObject(AppDI.shared().getUserInfoViewModel())
}
#endif
