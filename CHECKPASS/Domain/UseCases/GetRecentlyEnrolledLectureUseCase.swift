//
//  GetRecentlyEnrolledLectureUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/28/24.
//

import Combine

protocol GetRecentlyEnrolledLectureUseCase {
    func execute() -> AnyPublisher<[Lecture], Error>
}

class DefaultGetRecentlyEnrolledLectureUseCase<T: LectureRepository> {
    let repository: T
    
    init(repository: T) {
        self.repository = repository
    }
}

extension DefaultGetRecentlyEnrolledLectureUseCase: GetRecentlyEnrolledLectureUseCase {
    func execute() -> AnyPublisher<[Lecture], Error> {
        let url = "http://localhost:8080/enrollment"
        
        return repository.fetchLectures(url: url)
            .map { lectures in
                guard let lectures = lectures as? [Lecture] else {
                    fatalError("cannot cast to [Lecture] type")
                }
                
                return lectures
            }
            .eraseToAnyPublisher()
    }
}
