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
    func fetchDepartments(of college: String) -> AnyPublisher<Departments, Error> {
        let url = "http://localhost:8080/viewElement/departments/\(college)"
        return dataSource.sendGetRequest(to: url, resultType: DepartmentsDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
