//
//  LaunchScreenView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/22/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isChanged: Bool = false
    
    var body: some View {
        HStack {
            Image("CheckPassLogo_NoText")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.23)
            
            if isChanged {
                Image("CheckPass_Text")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .padding(30)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
                withAnimation(.bouncy) {
                    isChanged.toggle()
                }
            })
        }
    }
}

#Preview {
    LaunchScreenView()
}
