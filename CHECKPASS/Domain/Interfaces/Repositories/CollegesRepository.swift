//
//  CollegesRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/22/24.
//

import Combine

protocol CollegesRepository {
    func fetchColleges(to url: String) -> AnyPublisher<Colleges, Error>
}
