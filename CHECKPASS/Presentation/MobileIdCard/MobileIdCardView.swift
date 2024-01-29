//
//  MobileIdCardView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/26/24.
//

import SwiftUI

struct MobileIdCardView<UVM: UserInfoVM>: View {
    @EnvironmentObject private var userInfoViewModel: UVM
    @Binding private var showCardView: Bool
    @State private var isRotated: Bool = false
    
    init(showCardView: Binding<Bool>) {
        _showCardView = showCardView
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack {
                    if isRotated {
                        BackCard<UVM>(isRotated: $isRotated)
                            .environmentObject(userInfoViewModel)
                    } else {
                        FrontCard<UVM>(isRotated: $isRotated)
                            .environmentObject(userInfoViewModel)
                    }
                }
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom], UIScreen.main.bounds.height * 0.12)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            showCardView.toggle()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                        })
                    }
                }
                .rotation3DEffect(.degrees(isRotated ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .animation(.bouncy, value: isRotated)
            }
        }
    }
}

#Preview {
    MobileIdCardView<UserInfoViewModel>(showCardView: .constant(true))
        .environmentObject(AppDI.shared().getUserInfoViewModel())
}
