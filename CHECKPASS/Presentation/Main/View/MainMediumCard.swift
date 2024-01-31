//
//  AttendanceCardView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/25/24.
//

import SwiftUI

struct MainMediumCard: View {
    let title: String, image: String
    let xOffset: CGFloat?, yOffset: CGFloat?
    
    init(title: String, image: String,
         imageOffset: (x: CGFloat, y: CGFloat)? = nil) {
        self.title = title
        self.image = image
        self.xOffset = imageOffset?.x
        self.yOffset = imageOffset?.y
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.width * 0.4)
                .shadow(color: Color(red: 213 / 255, green: 213 / 255, blue: 213 / 255), radius: 5, y: 3)
            
            HStack {
                VStack {
                    Text("\(title)")
                        .bold()
                        .foregroundColor(.black)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding([.leading, .top])
            
            HStack {
                Spacer()
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: UIScreen.main.bounds.width * 0.25)
                    .padding(.trailing)
                    .offset(x: xOffset ?? 0, y: yOffset ?? 0)
            }
        }
    }
}

#Preview {
    MainMediumCard(title: "비콘으로", image: "dart")
}
