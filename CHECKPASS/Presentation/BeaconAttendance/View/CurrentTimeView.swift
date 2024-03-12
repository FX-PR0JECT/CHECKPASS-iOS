//
//  CurrentTimeView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/11/24.
//

import SwiftUI
import Foundation

struct CurrentTimeView: View {
    @State private var now = Date.now
    
    var body: some View {
        HStack(spacing: 3) {
            Spacer()
            
            Text("현재 시간: ")
            
            Text(now.formatDateToString(format: "yyyy-MM-dd hh시 mm분 ss초"))
            
            Spacer()
        }
        .font(.footnote)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                now = Date.now
            }
        }
    }
}

#Preview {
    CurrentTimeView()
}
