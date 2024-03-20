//
//  DefaultEditUserInfoRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/15/24.
//

import Combine
import Foundation

class DefaultEditUserInfoRepository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultEditUserInfoRepository: EditUserInfoRepository {
    func editUserInfo(url: String, params: Dictionary<String, String>) -> AnyPublisher<APIResult, Error> {
        dataSource.sendPatchRequest(with: params, to: url, resultType: APIResultDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
