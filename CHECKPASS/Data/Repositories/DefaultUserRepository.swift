//
//  DefaultUserRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/17/24.
//

import Combine
import Foundation

final class DefaultUserRepository {
    let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
}

extension DefaultUserRepository: UserRepository {    
    func fetchSimpleUserInfo(url: String) -> AnyPublisher<SimpleUserInfo?, Error> {
        return dataSource.sendGetRequest(url: url, resultType: SimpleUserInfoDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
    
}
