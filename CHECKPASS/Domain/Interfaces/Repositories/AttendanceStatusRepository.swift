//
//  AttendanceStatusRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/25/24.
//

import Combine

protocol AttendanceStatusRepository {
    func fetchStatus(url: String) -> AnyPublisher<[String], Error>
}
