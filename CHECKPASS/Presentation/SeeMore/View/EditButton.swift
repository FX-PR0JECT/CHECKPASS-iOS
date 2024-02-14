//
//  EditButton.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/11/24.
//

import SwiftUI

struct EditButton: View {
    var body: some View {
        Text("수정하기")
            .font(.caption)
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.gray, lineWidth: 0.5)
            }
    }
}

#Preview {
    EditButton()
}
