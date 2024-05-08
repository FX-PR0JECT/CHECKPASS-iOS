//
//  CheckPassLogoWhite.swift
//  CHECKPASS
//
//  Created by 이정훈 on 5/7/24.
//

import SwiftUI

struct CheckPassLogoWhite: View {
    var body: some View {
        HStack(spacing: 3) {
            Image("CheckPassLogo_NoText")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
            
            Image("CheckPass_Text")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .colorInvert()
        }
    }
}

#Preview {
    CheckPassLogoWhite()
}
