//
//  View.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/29/24.
//

import SwiftUI

extension View {
    func modifier<ModifiedContent: View>(
        @ViewBuilder body: (_ content: Self) -> ModifiedContent
    ) -> ModifiedContent {
        body(self)
    }
    
    //MARK: - keyboard dismiss method
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
