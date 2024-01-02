//
//  SignUpViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import Combine

final class SignUpViewModel: SignUpVM {
    @Published var states: Dictionary<String, InputState> = ["id": .isInitial, "pw": .isInitial, "pwConfirmation": .isInitial, "name": .isInitial, "email": .isInitial, "type": .isInitial, "college": .isInitial, "department": .isInitial, "agreement": .isInitial]
}

enum InputState {
    case isInitial
    case isBlank
    case isInvalid
    case isValid
}
