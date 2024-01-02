//
//  SignUpViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import Combine

final class SignUpViewModel: SignUpVM {
    @Published var states: [InputState] = [.isInitial, .isInitial, .isInitial, .isInitial, .isInitial, .isInitial, .isInitial, .isInitial, .isInitial]
}

enum InputState {
    case isInitial
    case isBlank
    case isInvalid
    case isValid
}
