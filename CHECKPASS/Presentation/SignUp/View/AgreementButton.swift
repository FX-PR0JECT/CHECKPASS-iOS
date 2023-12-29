//
//  AgreementButton.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/29/23.
//

import SwiftUI

struct AgreementButton: View {
    @Binding var status: InputStatus
    
    var body: some View {
        Button(action: {
            withAnimation {
                if status == .isValid {
                    status = .isBlank
                } else {
                    status = .isValid
                }
            }
                
        }, label: {
            switch status {
            case .isValid:
                Image(systemName: "checkmark.circle.fill")
            default:
                Image(systemName: "circle")
                
            }
        })
    }
}

#Preview {
    AgreementButton(status: .constant(.isInitial))
}
