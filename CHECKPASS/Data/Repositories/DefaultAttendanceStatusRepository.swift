//
//  DefaultAttendanceStatusRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/25/24.
//

import Combine

class DefaultAttendanceStatusRepository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultAttendanceStatusRepository: AttendanceStatusRepository {
    func fetchStatus(url: String) -> AnyPublisher<[String], Error> {
        dataSource.sendGetRequest(to: url, resultType: AttendanceStatusDTO.self)
            .map {
                $0.resultSet
            }
            .eraseToAnyPublisher()
    }
}
