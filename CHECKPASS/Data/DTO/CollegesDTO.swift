//
//  CollegesDTO.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/22/24.
//

import Foundation

// MARK: - CollegesDTO
struct CollegesDTO: Codable {
    let state: String
    let code: Int
    let title: String
    let resultSet: [String: String]    //key: kor collage name, value:  college eng name
    
    func toEntity() -> Colleges {
        return Colleges(collegesDictionary: resultSet)
    }
}
