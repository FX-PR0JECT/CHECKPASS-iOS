//
//  BeaconAttendanceUserInfo.swift
//  CHECKPASS
//
//  Created by 이정훈 on 5/6/24.
//

import SwiftUI

struct BeaconAttendanceUserInfo: View {
    @EnvironmentObject private var viewModel: DefaultBeaconAttendanceViewModel
    @EnvironmentObject private var userInfoViewModel: UserInfoViewModel
    
    var lecture: Lecture
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundColor(.white)
            .shadow(radius: 5)
            .overlay {
                VStack {
                    VStack {
                        HStack(spacing: 5) {
                            Text(lecture.lectureName)
                            
                            Text("\(lecture.division)")
                            
                            Spacer()
                        }
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(red: 97 / 255, green: 96 / 255, blue: 96 / 255))
                        
                        HStack {
                            Text(lecture.lectureRoom)
                            
                            Spacer()
                        }
                        .font(.subheadline)
                        .padding(.bottom, 30)
                        .foregroundColor(Color(red: 97 / 255, green: 96 / 255, blue: 96 / 255))
                        
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        
                        Text(userInfoViewModel.detailedUserInfo?.userName ?? "홍길동")
                            .multilineTextAlignment(.center)
                            .tracking(15)
                            .fontWeight(.heavy)
                            .font(.title2)
                            .padding(.bottom, 30)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Text("학번: \(String(userInfoViewModel.detailedUserInfo?.userId ?? 1234567))")
                                
                                Spacer()
                            }
                            
                            Text("단과대: \(userInfoViewModel.detailedUserInfo?.userCollege ?? "유저 단과대")")
                            
                            Text("전공: \(userInfoViewModel.simpleUserInfo?.userDepartment ?? "유저 전공")")
                        }
                        .foregroundColor(Color(red: 97 / 255, green: 96 / 255, blue: 96 / 255))
                        
                        Spacer()
                    }
                    .padding(30)
                    
                    ZStack {
                        Rectangle()
                            .frame(height: UIScreen.main.bounds.height * 0.07)
                            .ignoresSafeArea()
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 0,
                                    bottomLeadingRadius: 30,
                                    bottomTrailingRadius: 30,
                                    topTrailingRadius: 0
                                )
                            )
                            .foregroundColor(Color(red: 47 / 255, green: 83 / 255, blue: 154 / 255))
                        
                        HStack {
                            Image("CheckPassLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150)
                                .padding(.leading)
                            
                            Spacer()
                        }
                    }
                }
            }
    }
}

#Preview {
    BeaconAttendanceUserInfo(lecture: Lecture.sampleData)
        .environmentObject(AppDI.shared().getBeaconAttendanceViewModel())
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
