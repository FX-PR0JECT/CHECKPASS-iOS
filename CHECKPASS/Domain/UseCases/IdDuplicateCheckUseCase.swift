//
//  IdDuplicationCheckUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/8/24.
//

import Combine
import Foundation

protocol IdDuplicateCheckUseCase {
    func execute(_ data: String) -> AnyPublisher<APIResult, Error>
}

final class DefaultIdDuplicateCheckUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
}

extension DefaultIdDuplicateCheckUseCase: IdDuplicateCheckUseCase {
    func execute(_ data: String) -> AnyPublisher<APIResult, Error> {
        let publicIP = Bundle.main.publicIP
        let url: String = "http://\(publicIP)/users/duplication/\(data)"    //API URL
        return repository.requestAuthentication(url: url)
            .eraseToAnyPublisher()
    }
}
