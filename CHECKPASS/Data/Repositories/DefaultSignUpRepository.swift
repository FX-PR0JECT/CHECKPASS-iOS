//
//  DefaultSignUpRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

import Combine

final class DefaultSignUpRepository {
    private let dataSource: SignUpDataSource
    
    init(dataSource: SignUpDataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultSignUpRepository: SignUpRepository {
    func registerUserInfo(params: Dictionary<String, String>) -> AnyPublisher<SignUpResult, Error> {
        return dataSource.sendRegistrationData(params)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
