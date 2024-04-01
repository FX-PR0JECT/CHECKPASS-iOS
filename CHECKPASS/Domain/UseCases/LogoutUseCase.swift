//
//  LogoutUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/6/24.
//

import Combine
import Foundation

protocol LogoutUseCase {
    func execute() -> AnyPublisher<APIResult, Error>
}

final class DefaultLogoutUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
}

extension DefaultLogoutUseCase: LogoutUseCase {
    func execute() -> AnyPublisher<APIResult, Error> {
        let publicIP = Bundle.main.bundleURL
        let url = "http://\(publicIP)/logout"
        return repository.requestAuthentication(params: nil, to: url)
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
