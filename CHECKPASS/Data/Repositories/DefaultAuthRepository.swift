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
    func requestAuthentication(params: Dictionary<String, String>? = nil, to url: String) -> AnyPublisher<APIResult, Error> {
        return dataSource.sendPostRequest(with: params, to: url, resultType: APIResultDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
    
    func requestAuthentication(url: String) -> AnyPublisher<APIResult, Error> {
        return dataSource.sendGetRequest(to: url, resultType: APIResultDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
