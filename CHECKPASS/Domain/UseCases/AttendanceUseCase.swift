//
//  AttendanceUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/19/24.
//

import Combine

protocol AttendanceUseCase {
    func executeForEAttendance(attendanceCode: String) -> AnyPublisher<APIResult, Error>
    func executeForBeaconAttendance(byId lectureCode: Int) -> AnyPublisher<APIResult, Error>
}

class DefaultAttendanceUseCase {
    private let repository: AttendanceRepository
    
    init(repository: AttendanceRepository) {
        self.repository = repository
    }
}

extension DefaultAttendanceUseCase: AttendanceUseCase {
    func executeForEAttendance(attendanceCode: String) -> AnyPublisher<APIResult, Error> {
        let attendanceCode = Int(attendanceCode) ?? 0000
        let params = ["attendanceCode": attendanceCode]
        let url = "http://localhost:8080/attendance"
        return repository.attend(with: params, to: url)
    }
    
    func executeForBeaconAttendance(byId lectureCode: Int) -> AnyPublisher<APIResult, Error> {
        let url = "http://localhost:8080/attendance/\(lectureCode)"
        return repository.attend(to: url)
    }
}
