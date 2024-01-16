//
//  SignUpUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/2/24.
//

import Combine

protocol SignUpUseCase {
    func executeForStudent(_ data: Dictionary<String, String>) -> AnyPublisher<AuthResult, Error>
    func executeForStaff(_ data: Dictionary<String, String>) -> AnyPublisher<AuthResult, Error>
}

final class DefaultSignUpUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
}

extension DefaultSignUpUseCase: SignUpUseCase {
    func executeForStudent(_ data: Dictionary<String, String>) -> AnyPublisher<AuthResult, Error> {
        return repository.fetchPostResponse(params: data, for: .signUpForStudent)
    }
    
    
    
    func executeForStaff(_ data: Dictionary<String, String>) -> AnyPublisher<AuthResult, Error> {
        return repository.fetchPostResponse(params: data, for: .signUpForStaff)
            .eraseToAnyPublisher()
    }
}
