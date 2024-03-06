//
//  GetCurrentLectureUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/28/24.
//

import Combine

protocol GetCurrentUserLectureUseCase {
    func execute() -> AnyPublisher<[SimpleLecture], Error>
}

class DefaultGetCurrentUserLectureUseCase<T: LectureRepository> {
    let repository: T
    
    init(repository: T) {
        self.repository = repository
    }
}

extension DefaultGetCurrentUserLectureUseCase: GetCurrentUserLectureUseCase {
    func execute() -> AnyPublisher<[SimpleLecture], Error> {
        let url = "http://localhost:8080/enrollment"
        
        return repository.fetchLecture(url: url)
            .map { lectures in
                lectures.map {
                    guard let lecture = $0 as? SimpleLecture else {
                        fatalError("cannot cast to SimpleLecture type")
                    }
                    
                    return lecture
                }
            }
            .eraseToAnyPublisher()
    }
}
