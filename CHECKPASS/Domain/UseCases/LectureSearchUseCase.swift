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
        var url = "http://localhost:8080/lectures/search?"
        
        if let lectureGrade {
            if String(url.last!) != "?" {
                url += "&"
            }
            
            url += "grade=\(lectureGrade)"
        }
        
        if let lectureKind {
            if String(url.last!) != "?" {
                url += "&"
            }
            
            url += "kind=\(lectureKind)"
        }
        
        if let lectureGrades {
            if String(url.last!) != "?" {
                url += "&"
            }
            
            url += "grades=\(lectureGrades)"
        }
        
        if let lectureCode {
            if String(url.last!) != "?" {
                url += "&"
            }
            
            url += "lectureCode=\(lectureCode)"
        }
        
        if let lectureName {
            if String(url.last!) != "?" {
                url += "&"
            }
            
            url += "lectureName=\(lectureName)"
        }
        
        if let professorName {
            if String(url.last!) != "?" {
                url += "&"
            }
            
            url += "professorName=\(professorName)"
        }
        
        return repository.fetchLecture(url: url)
                .eraseToAnyPublisher()
    }
}
