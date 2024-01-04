//
//  SignUpUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/2/24.
//

import Combine

protocol SignUpUseCase {
    func execute(_ data: Dictionary<String, String>) -> AnyPublisher<SignUpResult, Error>
}

final class DefaultSignUpUseCase {
    private let repository: SignUpRepository
    
    init(repository: SignUpRepository) {
        self.repository = repository
    }
}

extension DefaultSignUpUseCase: SignUpUseCase {
    //MARK: - 
    func execute(_ data: Dictionary<String, String>) -> AnyPublisher<SignUpResult, Error> {
        return repository.registerUserInfo(params: data)
    }
}
