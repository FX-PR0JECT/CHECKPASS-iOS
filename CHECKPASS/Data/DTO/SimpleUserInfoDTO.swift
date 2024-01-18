//
//  SimpleUserInfoDTO.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/12/24.
//

import Foundation

// MARK: - StudentInfoDTO
struct SimpleUserInfoDTO: Codable {
    let state: String
    let code: Int
    let title: String
    let resultSet: ResultSet
}

// MARK: - ResultSet
struct ResultSet: Codable {
    let userId: Int
    let userName, userDepartment, userJob: String
}


//MARK: - Convert Domain
extension SimpleUserInfoDTO {
    func toEntity() -> SimpleUserInfo {
        return SimpleUserInfo(userId: resultSet.userId,
                              userName: resultSet.userName,
                              userDepartment: resultSet.userDepartment,
                              jobType: JobType(rawValue: resultSet.userJob))
    }
}
