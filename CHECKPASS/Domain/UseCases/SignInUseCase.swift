//
//  SignInUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/11/24.
//

import Combine

protocol SignInUseCase {
    func executeForSignIn(data: Dictionary<String, String>) -> AnyPublisher<APIResult, Error>
}

final class DefaultSignInUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
}

extension DefaultSignInUseCase: SignInUseCase {
    func executeForSignIn(data: Dictionary<String, String>) -> AnyPublisher<APIResult, Error> {
        return repository.fetchPostResponse(params: data, for: .signIn)
    }
    
    
}
