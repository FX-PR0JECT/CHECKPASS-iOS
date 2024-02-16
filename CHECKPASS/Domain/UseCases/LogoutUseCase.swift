//
//  LogoutUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/6/24.
//

import Combine
import Foundation

protocol LogoutUseCase {
    func executeForLogout() -> AnyPublisher<APIResult, Error>
}

final class DefaultLogoutUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
}

extension DefaultLogoutUseCase: LogoutUseCase {
    func executeForLogout() -> AnyPublisher<APIResult, Error> {
        return repository.fetchPostResponse(params: nil, for: .logout)
            .map {
                if $0.result {
                    UserDefaults.standard.removeObject(forKey: "id")
                    UserDefaults.standard.removeObject(forKey: "pw")
                }
                
                return $0
            }
            .eraseToAnyPublisher()
    }
}
