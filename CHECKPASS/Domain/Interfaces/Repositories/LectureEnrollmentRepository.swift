//
//  LectureEnrollmentRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/26/24.
//

import Combine

protocol LectureEnrollmentRepository {
    func registerLecture(url: String) -> AnyPublisher<APIResult, Error>
}
