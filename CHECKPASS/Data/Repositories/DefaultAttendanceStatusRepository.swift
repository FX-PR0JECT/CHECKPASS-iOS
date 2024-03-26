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
    func fetchStatus(url: String) -> AnyPublisher<[AttendanceStatuses], Error> {
        dataSource.sendGetRequest(to: url, resultType: AttendanceStatusDTO.self)
            .map { DTO in
                var statuses = [AttendanceStatuses]()
                
                DTO.resultSet.forEach { status in
                    if status.count == 1 {    //String count: 1
                        if let attendanceStatus = AttendanceStatus(rawValue: status) {
                            statuses.append(AttendanceStatuses(firstStatus: attendanceStatus))
                        }
                    } else {    //String count: 2
                        if let firstStatus = AttendanceStatus(rawValue: String(status.subCharacter(at: 0))),
                           let secondStatus = AttendanceStatus(rawValue: String(status.subCharacter(at: 1))) {
                            statuses.append(AttendanceStatuses(firstStatus: firstStatus,
                                                               secondStatus: secondStatus))
                        }
                    }
                }
                
                return statuses
            }
            .eraseToAnyPublisher()
    }
}
