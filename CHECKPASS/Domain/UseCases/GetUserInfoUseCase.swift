//
//  GetUserProfileUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/17/24.
//

import Combine
import Foundation

protocol GetUserInfoUseCase {
    func executeGetSimpleUserInfo() -> AnyPublisher<SimpleUserInfo, Error>
}

final class DefaultGetUserInfoUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
}

extension DefaultGetUserInfoUseCase: GetUserInfoUseCase {
    func executeGetSimpleUserInfo() -> AnyPublisher<SimpleUserInfo, Error> {
        let id = UserDefaults.standard.string(forKey: "id")
        
        guard let userId = id else {
            fatalError()
        }
        
        let url = "http://localhost:8080/users/simple/\(userId)"
        return repository.fetchSimpleUserInfo(url: url)
    }
}
