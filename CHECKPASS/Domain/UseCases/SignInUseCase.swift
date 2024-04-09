//
//  SignInUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/11/24.
//

import Combine
import Foundation

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
//        let publicIP = Bundle.main.publicIP
//        let url = "http://\(publicIP)/login"
        let domain = Bundle.main.domain
        let url = "\(domain)/login"
        return repository.requestAuthentication(params: data, to: url)
    }
    
    
}
