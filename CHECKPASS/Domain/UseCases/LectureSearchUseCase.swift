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
        let url = "http://localhost:8080/lectures/search?(grade=\(lectureGrade ?? "null"))&(kind=\(lectureKind ?? "null"))&(grades=\(lectureGrades ?? "null")&(lectureCode=\(lectureCode ?? "null"))&(lectureName=\(lectureName ?? "null")&(professorName=\(professorName ?? "null"))"
        
        return repository.fetchLecture(url: url)
                .eraseToAnyPublisher()
    }
}
