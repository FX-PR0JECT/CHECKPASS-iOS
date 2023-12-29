//
//  KeyboardVM.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/26/23.
//

import Combine

protocol KeyboardVM: ObservableObject {
    var isKeyboardVisible: Bool { get set }
}
