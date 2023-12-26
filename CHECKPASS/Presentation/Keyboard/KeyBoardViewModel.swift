//
//  KeyBoardViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/26/23.
//

import Foundation
import Combine
import SwiftUI

final class KeyboardViewModel: KeyboardVM {
    @Published var isKeyboardVisible: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        monitorKeyboardAppear()
        monitorKeyboardDisappear()
    }
    
    //MARK: - Keyboard appear
    private func monitorKeyboardAppear() {
        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillShowNotification
        )
        .sink { [weak self] notification in
            withAnimation(.bouncy) {
                self?.isKeyboardVisible = true
            }
        }
        .store(in: &subscriptions)
    }
    
    //MARK: - Keyboard disappear
    private func monitorKeyboardDisappear() {
        NotificationCenter.Publisher(
            center: NotificationCenter.default,
            name: UIResponder.keyboardWillHideNotification
        )
        .sink { [weak self] notification in
            withAnimation(.bouncy) {
                self?.isKeyboardVisible = false
            }
        }
        .store(in: &subscriptions)
    }
}
