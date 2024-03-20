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
    func fetchColleges() -> AnyPublisher<Colleges, Error> {
        let url = "http://localhost:8080/viewElement/colleges"
        return dataSource.sendGetRequest(to: url, resultType: CollegesDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
