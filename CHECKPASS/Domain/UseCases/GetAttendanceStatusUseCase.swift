//
//  GetAttendanceStatusUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/25/24.
//

import Combine
import Foundation

protocol GetAttendanceStatusUseCase {
    func execute(for lectureId: Int) -> AnyPublisher<[AttendanceStatuses], Error>
}

class DefaultGetAttendanceStatusUseCase {
    private let repository: AttendanceStatusRepository
    
    init(repository: AttendanceStatusRepository) {
        self.repository = repository
    }
}

extension DefaultGetAttendanceStatusUseCase: GetAttendanceStatusUseCase {
    //MARK: - fetch attendance status for specific lecture
    func execute(for lectureId: Int) -> AnyPublisher<[AttendanceStatuses], Error> {
        let publicIP = Bundle.main.publicIP
        let url = "http://\(publicIP)/attendance/\(lectureId)"
        return repository.fetchStatus(url: url)
    }
}
