//
//  BeaconAttendanceButtonLabel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/11/24.
//

import SwiftUI

struct BeaconAttendanceButtonLabel: View {
    @State private var animationCount = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(height: UIScreen.main.bounds.width * 0.4)
            .foregroundColor(Color(red: 76 / 255, green: 63 / 255, blue: 233 / 255))
            .shadow(color: Color(red: 213 / 255, green: 213 / 255, blue: 213 / 255), radius: 5, y: 3)
            .overlay {
                VStack {
                    if #available(iOS 17.0, *) {
                        Image(systemName: "iphone.radiowaves.left.and.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.15)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                            .symbolEffect(.bounce, value: animationCount)
                    } else {
                        Image(systemName: "iphone.radiowaves.left.and.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.15)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                    }
                    
                    Text("터치하여 출석하기")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    animationCount += 1
                }
            }
    }
}

#Preview {
    BeaconAttendanceButtonLabel()
}
