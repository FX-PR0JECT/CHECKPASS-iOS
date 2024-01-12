//
//  DefaultRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/12/24.
//

import Combine

final class DefaultRepository: Repository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultRepository {
    func fetchPostResponse<T: DTO>(params: Dictionary<String, String>, for classification: PostRequestUrl, resultType: T.Type) -> AnyPublisher<Entity, Error> {
        return dataSource.sendPostRequest(params, for: classification, resultType: T.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchGetResponse<T: DTO>(url: String, resultType: T.Type) -> AnyPublisher<Entity, Error> {
        return dataSource.sendGetRequest(url: url, resultType: T.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
