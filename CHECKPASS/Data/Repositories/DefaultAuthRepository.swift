//
//  DefaultAuthRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

import Combine

final class DefaultAuthRepository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultAuthRepository: AuthRepository {
    //MARK: - send User information to sign up & sign in
    func sendUserInfo(params: Dictionary<String, String>, for classification: RequestPostUrl) -> AnyPublisher<AuthResult, Error> {
        return dataSource.sendPostRequest(params, for: classification, resultType: AuthResponseDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - send id information to check for id duplication
    func sendIdInfo(id: String) -> AnyPublisher<AuthResult, Error> {
        let url: String = "http://localhost:8080/users/duplication/\(id)"    //API URL
        return dataSource.sendGetRequest(url: url, resultType: AuthResponseDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
