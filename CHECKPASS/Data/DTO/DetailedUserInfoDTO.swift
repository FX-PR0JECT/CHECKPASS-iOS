//
//  DetailedUserInfoDTO.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/7/24.
//

import Foundation

// MARK: - DetailUserInfoDTO
struct DetailedUserInfoDTO: Codable {
    let state: String
    let code: Int
    let title: String
    let resultSet: DetailedUserInfoResultSet
}

// MARK: - ResultSet
struct DetailedUserInfoResultSet: Codable {
    let userId: Int
    let userName, userJob, userDepartment, userCollege: String
    let studentGrade, dayOrNight, studentSemester: String?
    let hiredate: String?
}

