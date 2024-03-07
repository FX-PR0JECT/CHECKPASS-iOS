//
//  EnrollmentHistoryDTO.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/6/24.
//

import Foundation

// MARK: - EnrollmentHistoryDTO
struct EnrollmentHistoryDTO: Codable {
    let state: String
    let code: Int
    let title: String
    let resultSet: Dictionary<String, [LectureResultSet]>
}
