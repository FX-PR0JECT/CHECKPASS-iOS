//
//  GetEnrollmentHistoryUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/6/24.
//

import Combine

typealias History = [String: [SimpleLecture]]

protocol GetEnrollmentHistoryUseCase {
    func execute() -> AnyPublisher<History, Error>
}

class DefaultGetEnrollmentHistoryUseCase<T: LectureRepository> {
    let repository: T
    
    init(repository: T) {
        self.repository = repository
    }
}

extension DefaultGetEnrollmentHistoryUseCase: GetEnrollmentHistoryUseCase {
    func execute() -> AnyPublisher<History, Error> {
        let url = "http://localhost:8080/enrollment/history"
        
        return repository.fetchLecture(url: url)
            .map { history in
                guard let history = history as? History else {
                    fatalError("history can not be converted to History type")
                }
                
                return history
            }
            .eraseToAnyPublisher()
    }
}
