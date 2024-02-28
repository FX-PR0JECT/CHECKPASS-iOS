//
//  LectureEnrollmentUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/26/24.
//

import Combine

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
        let url = "http://localhost:8080/enrollment/\(lectureId)"
        return repository.registerLecture(url: url)
    }
}
