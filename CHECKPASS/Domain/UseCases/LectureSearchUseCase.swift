//
//  LectureSearchUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/21/24.
//

import Combine
import Foundation

protocol LectureSearchUseCase {
    func execute(lectureGrade: String?, lectureKind: String?, lectureGrades: String?,
                 lectureCode: String?, lectureName: String?, professorName: String?) -> AnyPublisher<[LectureInfo], Error>
}

class DefaultLectureSearchUseCase {
    private let repository: LectureSearchRepository
    
    init(repository: LectureSearchRepository) {
        self.repository = repository
    }
}

extension DefaultLectureSearchUseCase: LectureSearchUseCase {
    func execute(lectureGrade: String?, lectureKind: String?, lectureGrades: String?,
                 lectureCode: String?, lectureName: String?, professorName: String?) -> AnyPublisher<[LectureInfo], Error> {
        let url = "http://localhost:8080/lectures"
//        let params: [String: Any] = [
//            "lectureGrade": lectureGrade ?? NSNull(),
//            "lectureKind": lectureKind ?? NSNull(),
//            "lectureGrades": lectureGrades ?? NSNull(),
//            "lectureCode": lectureCode ?? NSNull(),
//            "lectureName": lectureName ?? NSNull(),
//            "professorName": professorName ?? NSNull()
//        ]
        
        let params: [String: Any] = [
            "lectureGrade": lectureGrade ?? NSNull(),
            "lectureKind": lectureKind ?? NSNull(),
            "lectureGrades": lectureGrades ?? NSNull(),
            "lectureCode": lectureCode ?? NSNull(),
            "lectureName": "데이터베이스",
            "professorName": professorName ?? NSNull()
        ]
        
        return repository.fetchLecture(url: url, params: params)
                .eraseToAnyPublisher()
    }
}
