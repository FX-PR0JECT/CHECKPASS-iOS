//
//  SignUpRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

import Combine

protocol SignUpRepository {
    func registerUserInfo(params: Dictionary<String, String>) -> AnyPublisher<SignUpResult, Error>
}
