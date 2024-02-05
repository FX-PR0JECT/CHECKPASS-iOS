//
//  Sectionheader.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/2/24.
//

import SwiftUI

struct Sectionheader: View {
    let header: String
    
    var body: some View {
        Text(header)
            .bold()
            .font(.title3)
            .foregroundColor(.black)
    }
}

#Preview {
    Sectionheader(header: "학기 선택")
}
