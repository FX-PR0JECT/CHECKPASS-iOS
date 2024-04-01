//
//  DefaultDepartmentsRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/22/24.
//

import Combine

final class DefaultDepartmentsRepository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultDepartmentsRepository: DepartmentsRepository {    
    func fetchDepartments(to url: String) -> AnyPublisher<Departments, Error> {
        return dataSource.sendGetRequest(to: url, resultType: DepartmentsDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
