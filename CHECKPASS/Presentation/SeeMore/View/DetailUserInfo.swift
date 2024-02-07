//
//  DetailUserInfo.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/7/24.
//

import SwiftUI

struct DetailUserInfo<UVM: UserInfoVM>: View {
    @EnvironmentObject private var userInfoViewModel: UVM
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailUserInfo<UserInfoViewModel>()
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
