//
//  MainSubTitle.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/25/24.
//

import SwiftUI

struct MainSubTitle: View {
    let subTitle: String
    
    init(_ subtitle: String) {
        self.subTitle = subtitle
    }
    
    var body: some View {
        HStack {
            Text(subTitle)
                .font(.title2)
                .bold()
            
            Spacer()
        }
        .padding([.leading, .top])
        .offset(x: 10)
    }
}

#Preview {
    MainSubTitle("테스트")
}
