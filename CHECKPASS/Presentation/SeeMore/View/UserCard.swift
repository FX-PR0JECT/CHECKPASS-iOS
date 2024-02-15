//
//  UserCard.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/7/24.
//

import SwiftUI

struct UserCard: View {
    @Binding private var simpleUserInfo: SimpleUserInfo?
    
    init(simpleUserInfo: Binding<Optional<SimpleUserInfo>>) {
        _simpleUserInfo = simpleUserInfo
    }
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading) {
                Text("\(simpleUserInfo?.userName ?? "")")
                    .bold()
                    .font(.headline)
                
                Text("상세정보 확인하기")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

#if DEBUG
#Preview {
    UserCard(simpleUserInfo: .constant(SimpleUserInfo.sampleData))
}
#endif
