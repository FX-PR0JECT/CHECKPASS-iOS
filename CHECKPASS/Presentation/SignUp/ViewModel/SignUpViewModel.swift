//
//  SignUpViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import Combine

final class SignUpViewModel: SignUpVM {
    @Published var statuses: [InputStatus] = [.isInitial, .isInitial, .isInitial, .isInitial, .isInitial, .isInitial, .isInitial, .isInitial, .isInitial]
}

enum InputStatus {
    case isInitial
    case isBlank
    case isNotValid
    case isValid
}
