//
//  BeaconIcon.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/8/24.
//

import SwiftUI
import Foundation

struct BeaconIcon: View {
    @State private var animationCount = 0
    
    var body: some View {
        Circle()
            .fill(Color(red: 47 / 255, green: 83 / 255, blue: 154 / 255))
            .frame(width: 50, height: 50)
            .overlay {
                Image(systemName: "dot.radiowaves.up.forward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(270))
            }
    }
}

#Preview {
    BeaconIcon()
}
