//
//  CustomProgressView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/15/24.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 80, height: 80)
            .foregroundColor(Color(red: 227 / 255, green: 227 / 255, blue: 227 / 255))
            .overlay {
                ProgressView()
                    .scaleEffect(1.5)
            }
    }
}

#Preview {
    CustomProgressView()
}
