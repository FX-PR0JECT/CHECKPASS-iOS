//
//  AuthRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/8/24.
//

import Combine

protocol AuthRepository {
    func sendUserInfo(params: Dictionary<String, String>, for classification: PostRequestUrl) -> AnyPublisher<AuthResult, Error>
    func sendIdInfo(id: String) -> AnyPublisher<AuthResult, Error>
}
