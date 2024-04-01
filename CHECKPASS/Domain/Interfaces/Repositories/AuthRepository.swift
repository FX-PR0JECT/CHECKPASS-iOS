//
//  AuthRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/8/24.
//

import Combine

protocol AuthRepository {
    func requestAuthentication(params: Dictionary<String, String>?, to url: String) -> AnyPublisher<APIResult, Error>
    func requestAuthentication(url: String) -> AnyPublisher<APIResult, Error>
}
