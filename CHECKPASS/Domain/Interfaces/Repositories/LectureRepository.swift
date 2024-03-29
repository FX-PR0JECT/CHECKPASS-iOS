//
//  LectureRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/21/24.
//

import Combine

protocol LectureRepository {
    associatedtype result: Collection
    
    func fetchLectures(url: String) -> AnyPublisher<result, Error>
}
