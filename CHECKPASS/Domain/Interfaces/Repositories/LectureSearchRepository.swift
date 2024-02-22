//
//  SearchLectureRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/21/24.
//

import Combine

protocol LectureSearchRepository {
    func fetchLecture(url: String, params: Dictionary<String, Any>) -> AnyPublisher<[LectureInfo], Error>
}
