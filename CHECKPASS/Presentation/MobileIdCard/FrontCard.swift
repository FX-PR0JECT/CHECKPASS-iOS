//
//  FrontCard.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/26/24.
//

import SwiftUI

struct FrontCard<UVM: UserInfoVM>: View {
    @EnvironmentObject private var userInfoViewModel: UVM
    @Binding private var isRotated: Bool
    
    init(isRotated: Binding<Bool>) {
        _isRotated = isRotated
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.white)
                .shadow(radius: 3)
            
            Image("qr_code")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.4)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("모바일 신분증")
                        
                        Text("한국교통대학교")
                            .font(.title)
                            .bold()
                        
                        Text(userInfoViewModel.simpleUserInfo?.userName ?? "")
                            .font(.title2)
                    }
                    
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
                
                Spacer()
                
                HStack {
                    Image("CheckPassLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.3)
                    
                    Spacer()
                }
            }
            .padding(30)
            .foregroundColor(.black)
        }
    }
}

#Preview {
    FrontCard<UserInfoViewModel>(isRotated: .constant(false))
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
