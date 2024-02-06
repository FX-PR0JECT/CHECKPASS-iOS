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
    func fetchPostResponse(params: Dictionary<String, String>? = nil, for classification: PostRequestUrl) -> AnyPublisher<AuthResult, Error> {
        return dataSource.sendPostRequest(params, for: classification, resultType: AuthDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchGetResponse(url: String) -> AnyPublisher<AuthResult, Error> {
        return dataSource.sendGetRequest(url: url, resultType: AuthDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
