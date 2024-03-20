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
    func fetchPostResponse(params: Dictionary<String, String>? = nil, for classification: PostRequestUrl) -> AnyPublisher<APIResult, Error> {
        return dataSource.sendPostRequest(with: params, to: classification, resultType: APIResultDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchGetResponse(url: String) -> AnyPublisher<APIResult, Error> {
        return dataSource.sendGetRequest(to: url, resultType: APIResultDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
