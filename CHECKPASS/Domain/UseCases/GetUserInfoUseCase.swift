//
//  GetUserProfileUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/17/24.
//

import Combine
import Foundation

protocol GetUserInfoUseCase {
    func executeForSimpleUserInfo() -> AnyPublisher<SimpleUserInfo?, Error>
    func executeForDetailedUserInfo() -> AnyPublisher<User, Error>
}

final class DefaultGetUserInfoUseCase {
    private let repository: UserRepository
    private let domain = Bundle.main.domain
    
    init(repository: UserRepository) {
        self.repository = repository
    }
}

extension DefaultGetUserInfoUseCase: GetUserInfoUseCase {
    enum UserInfoError: Error {
        case idIsNil(message: String)
        case jobMissMatching(message: String)
    }
    
    //MARK: - fetch simple user data
    func executeForSimpleUserInfo() -> AnyPublisher<SimpleUserInfo?, Error> {
        let id = UserDefaults.standard.string(forKey: "id")
        guard let userId = id else {
            return Fail<SimpleUserInfo?, Error>(error: UserInfoError.idIsNil(message: "there is no id"))
                .eraseToAnyPublisher()
        }
        
//        let publicIP = Bundle.main.publicIP
//        let url = "http://\(publicIP)/users/simple/\(userId)"
        let url = "\(domain)/users/simple/\(userId)"
        return repository.fetchSimpleUserInfo(url: url)
    }
    
    //MARK: - fetch detailed user data
    func executeForDetailedUserInfo() -> AnyPublisher<User, Error> {
        let id = UserDefaults.standard.string(forKey: "id")
        guard let userId = id else {
            return Fail<User, Error>(error: UserInfoError.idIsNil(message: "there is no id"))
                .eraseToAnyPublisher()
        }
        
//        let publicIP = Bundle.main.publicIP
//        let url = "http://\(publicIP)/users/\(userId)"
        let url = "\(domain)/users/\(userId)"
        return repository.fetchDetailedUserInfo(url: url)
            .flatMap { value -> AnyPublisher<User, Error> in
                switch value {
                case .some(let user):
                    return Just(user)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                case .none:
                    return Fail<User, Error>(error: UserInfoError.jobMissMatching(message: "JobType mismatching"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
