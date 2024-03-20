//
//  DefaultLectureEnrollmentRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/26/24.
//

import Combine

class DefaultLectureEnrollmentRepository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultLectureEnrollmentRepository: LectureEnrollmentRepository {
    func registerLecture(url: String) -> AnyPublisher<APIResult, Error> {
        return dataSource.sendPostRequest(to: url, resultType: APIResultDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
}
