//
//  GetRecentlyEnrolledLectureUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/28/24.
//

import Combine
import Foundation

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
//        let publicIP = Bundle.main.publicIP
//        let url = "http://\(publicIP)/enrollment"
        let domain = Bundle.main.domain
        let url = "\(domain)/enrollment"
        
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
