//
//  CardDetail.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/26/24.
//

import SwiftUI

struct CardDetail: View {
    private let title: String
    private let content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            Text(content)
                .font(.title3)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    CardDetail(title: "이름", content: "홍길동")
}
