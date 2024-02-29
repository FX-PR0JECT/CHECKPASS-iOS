//
//  SearchLectureRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/21/24.
//

import Combine

protocol LectureRepository {
    associatedtype lecture
    
    func fetchLecture(url: String) -> AnyPublisher<[lecture], Error>
}
