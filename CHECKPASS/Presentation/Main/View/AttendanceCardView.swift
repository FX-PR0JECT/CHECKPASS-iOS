//
//  AttendanceCardView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/25/24.
//

import SwiftUI

struct AttendanceCardView: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.width * 0.4)
                .foregroundColor(.white)
                .shadow(radius: 2)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(title)")
                        
                        Text("출석하기")
                    }
                    .bold()
                    .foregroundColor(.black)
                    .font(.callout)
                    
                    Spacer()
                }
                .padding([.leading, .top])
                
                Spacer()
            }
        }
    }
}

#Preview {
    AttendanceCardView("비콘으로")
}
