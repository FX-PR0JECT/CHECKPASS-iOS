//
//  SeeMoreView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/24/24.
//

import SwiftUI

struct SeeMoreView: View {
    @State private var showLogoutAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("로그인 관리")) {
                    Button(action: {
                        showLogoutAlert.toggle()
                    }, label: {
                        Text("로그아웃")
                            .foregroundColor(.red)
                    })
                    .alert("계정에서 로그아웃 하시겠어요?", isPresented: $showLogoutAlert) {
                        Button(role: .destructive) {
                            // Handle the deletion.
                        } label: {
                            Text("로그아웃")
                        }
                    }
                }
            }
            .navigationTitle("더보기")
            .navigationBarTitleDisplayMode(.large)
            .listStyle(.plain)
        }
    }
}

#Preview {
    SeeMoreView()
}
