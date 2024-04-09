//
//  AttendanceUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/19/24.
//

import Combine
import Foundation

protocol AttendanceUseCase {
    func executeForEAttendance(byId lectureId: Int, attendanceCode: String) -> AnyPublisher<APIResult, Error>
    func executeForBeaconAttendance(byId lectureCode: Int) -> AnyPublisher<APIResult, Error>
}

class DefaultAttendanceUseCase {
    private let repository: AttendanceRepository
//    private let publicIP = Bundle.main.publicIP
    private let domain = Bundle.main.domain
    
    init(repository: AttendanceRepository) {
        self.repository = repository
    }
}

extension DefaultAttendanceUseCase: AttendanceUseCase {
    func executeForEAttendance(byId lectureId: Int, attendanceCode: String) -> AnyPublisher<APIResult, Error> {
        let attendanceCode = Int(attendanceCode) ?? 0000
        let params = ["attendanceCode": attendanceCode]
//        let url = "http://\(publicIP)/attendance/token/\(lectureId)"
        let url = "\(domain)/attendance/token/\(lectureId)"
        return repository.attend(with: params, to: url)
    }
    
    func executeForBeaconAttendance(byId lectureCode: Int) -> AnyPublisher<APIResult, Error> {
//        let url = "http://\(publicIP)/attendance/\(lectureCode)"
        let url = "\(domain)/attendance/\(lectureCode)"
        return repository.attend(to: url)
    }
}
