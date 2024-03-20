//
//  DefaultAttendanceRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/19/24.
//

import Combine

class DefaultAttendanceRepository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultAttendanceRepository: AttendanceRepository {    
    func attendUsingBeacon(to url: String) -> AnyPublisher<APIResult, Error> {
        return dataSource.sendPostRequest(url: url, resultType: APIResultDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
    
    func attendUsingEAttendance(with params: Dictionary<String, Int>, to url: String) -> AnyPublisher<APIResult, Error> {
        return dataSource.sendMultipartFormDataRequest(with: params, to: url, resultType: APIResultDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
