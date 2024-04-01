//
//  LectureEnrollmentUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/26/24.
//

import Combine
import Foundation

protocol LectureEnrollmentUseCase {
    func execute(lectureId: Int) -> AnyPublisher<APIResult, Error>
}

class DefaultLectureEnrollmentUseCase {
    private let repository: LectureEnrollmentRepository
    
    init(repository: LectureEnrollmentRepository) {
        self.repository = repository
    }
}

extension DefaultLectureEnrollmentUseCase: LectureEnrollmentUseCase {
    func execute(lectureId: Int) -> AnyPublisher<APIResult, Error> {
        let publicIP = Bundle.main.publicIP
        let url = "http://\(publicIP)/enrollment/\(lectureId)"
        return repository.registerLecture(url: url)
    }
}
