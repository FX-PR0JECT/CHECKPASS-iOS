//
//  BackCard.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/26/24.
//

import SwiftUI

struct BackCard<UVM: UserInfoVM>: View {
    @EnvironmentObject private var userInfoViewModel: UVM
    @Binding private var isRotated: Bool
    
    init(isRotated: Binding<Bool>) {
        _isRotated = isRotated
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(red: 26 / 255, green: 58 / 255, blue: 183 / 255))
                .shadow(radius: 3)
            
            VStack(spacing: 20) {
                HStack {
                    Text("모바일 신분증")
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        isRotated.toggle()
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundColor(.gray)
                    })
                }
                .padding(.bottom, 20)
                
                CardDetail(title: "이름", content: userInfoViewModel.simpleUserInfo?.userName ?? "")
                
                if userInfoViewModel.simpleUserInfo?.jobType == .student {
                    CardDetail(title: "학번", content: "\(String(describing: userInfoViewModel.simpleUserInfo?.userId ?? 0))")
                } else {
                    CardDetail(title: "교직원 번호", content: "\(String(describing: userInfoViewModel.simpleUserInfo?.userId ?? 0))" )
                }
                
                CardDetail(title: "학과", content: userInfoViewModel.simpleUserInfo?.userDepartment ?? "")
                
                Spacer()
            }
            .padding(30)
        }
        .scaleEffect(x: -1, y: 1)
    }
}

#Preview {
    BackCard<UserInfoViewModel>(isRotated: .constant(true))
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
