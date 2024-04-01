//
//  DefaultCollegesRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/22/24.
//

import Combine

final class DefaultCollegesRepository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultCollegesRepository: CollegesRepository {
    func fetchColleges(to url: String) -> AnyPublisher<Colleges, Error> {
        return dataSource.sendGetRequest(to: url, resultType: CollegesDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
