//
//  UserRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/17/24.
//

import Combine

protocol UserRepository {
    func fetchSimpleUserInfo(url: String) -> AnyPublisher<SimpleUserInfo?, Error>
}
