//
//  SignInUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/11/24.
//

import Combine

protocol SignInUseCase {
    func executeForSignIn(data: Dictionary<String, String>) -> AnyPublisher<AuthEntity, Error>
}

final class DefaultSignInUseCase {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
}

extension DefaultSignInUseCase: SignInUseCase {
    func executeForSignIn(data: Dictionary<String, String>) -> AnyPublisher<AuthEntity, Error> {
        return repository.fetchPostResponse(params: data, for: .signIn, resultType: TestDTO.self)
            .map {
                $0 as! AuthEntity
            }
            .mapError {
                $0 as Error
            }
            .eraseToAnyPublisher()
    }
}
