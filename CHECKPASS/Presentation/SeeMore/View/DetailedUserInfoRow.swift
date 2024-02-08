//
//  DetailedUserInfoRow.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/8/24.
//

import SwiftUI

struct DetailedUserInfoRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .bold()
            
            Spacer()
            
            Text(value)
        }
    }
}

#Preview {
    DetailedUserInfoRow(title: "이름", value: "홍길동")
}
