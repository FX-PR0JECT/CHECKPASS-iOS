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
        if #available(iOS 17.0, *) {
            Circle()
                .fill(.beaconIconBackground)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "dot.radiowaves.up.forward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(.white)
                        .symbolEffect(.bounce, value: animationCount)
                        .rotationEffect(.degrees(270))
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        self.animationCount += 1
                    }
                }
        } else {
            Circle()
                .fill(.beaconIconBackground)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "dot.radiowaves.left.and.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundColor(.white)
                }
        }
    }
}

#Preview {
    BeaconIcon()
}
