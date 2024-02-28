//
//  AuthDTO.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/16/24.
//

import Foundation

struct APIResultDTO: Codable {
    let state: String
    let code: Int
    let title: String
    let resultSet: String
}

extension APIResultDTO {
    func toEntity() -> APIResult {
        return APIResult(result: state == "SUCCESS" ? true : false, code: code, resultSet: resultSet)
    }
}
