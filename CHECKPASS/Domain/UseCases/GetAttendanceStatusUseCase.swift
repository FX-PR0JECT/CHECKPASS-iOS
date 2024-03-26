//
//  GetAttendanceStatusUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/25/24.
//

import Combine

protocol GetAttendanceStatusUseCase {
    func execute(for lectureId: String) -> AnyPublisher<[String], Error>
}

class DefaultGetAttendanceStatusUseCase {
    private let repository: AttendanceStatusRepository
    
    init(repository: AttendanceStatusRepository) {
        self.repository = repository
    }
}

extension DefaultGetAttendanceStatusUseCase: GetAttendanceStatusUseCase {
    //MARK: - fetch attendance status for specific lecture
    func execute(for lectureId: String) -> AnyPublisher<[AttendanceStatuses], Error> {
        let url = "http://localhost:8080/attendance/\(lectureId)"
        return repository.fetchStatus(url: url)
    }
}
