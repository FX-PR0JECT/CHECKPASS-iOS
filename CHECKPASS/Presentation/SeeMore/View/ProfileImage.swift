//
//  ProfileImage.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/8/24.
//

import SwiftUI

struct ProfileImage: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .foregroundColor(.gray)
            
            ZStack {
                Circle()
                    .frame(width: 30)
                    .foregroundColor(.white)
                    .overlay(Circle().stroke())
                
                Image(systemName: "camera.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 17)
            }
            .offset(x: 30)
        }
    }
}

#Preview {
    ProfileImage()
}
