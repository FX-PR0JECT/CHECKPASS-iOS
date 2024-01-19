//
//  IdDuplicationCheckUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/8/24.
//

import Combine

protocol IdDuplicateCheckUseCase {
    func execute(_ data: String) -> AnyPublisher<AuthResult, Error>
}

final class DefaultIdDuplicateCheckUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
}

extension DefaultIdDuplicateCheckUseCase: IdDuplicateCheckUseCase {
    func execute(_ data: String) -> AnyPublisher<AuthResult, Error> {
        let url: String = "http://localhost:8080/users/duplication/\(data)"    //API URL
        return repository.fetchGetResponse(url: url)
            .eraseToAnyPublisher()
    }
}
