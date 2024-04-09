//
//  AttendanceStatusDTO.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/25/24.
//

import Foundation

// MARK: - AttendanceStatusDTO
struct AttendanceStatusDTO: Codable {
    let state: String
    let code: Int
    let title: String
    let resultSet: AttendanceStatusResultSet
}

// MARK: - ResultSet
struct AttendanceStatusResultSet: Codable {
    let lectureName: String
    let attendList: [String]
}
