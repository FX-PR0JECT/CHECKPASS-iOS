//
//  GetRecentlyEnrolledLectureUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/28/24.
//

import Combine

protocol GetRecentlyEnrolledLectureUseCase {
    func execute() -> AnyPublisher<[SimpleLecture], Error>
}

class DefaultGetRecentlyEnrolledLectureUseCase<T: LectureRepository> {
    let repository: T
    
    init(repository: T) {
        self.repository = repository
    }
}

extension DefaultGetRecentlyEnrolledLectureUseCase: GetRecentlyEnrolledLectureUseCase {
    func execute() -> AnyPublisher<[SimpleLecture], Error> {
        let url = "http://localhost:8080/enrollment"
        
        return repository.fetchLectures(url: url)
            .map { lectures in
                guard let lectures = lectures as? [SimpleLecture] else {
                    fatalError("cannot cast to [SimpleLecture] type")
                }
                
                return lectures
            }
            .eraseToAnyPublisher()
    }
}
