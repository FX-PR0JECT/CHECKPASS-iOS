//
//  AuthDTO.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/16/24.
//

import Foundation

struct AuthDTO: Codable {
    let state: String
    let code: Int
    let title: String
    let resultSet: String
}

extension AuthDTO {
    func toEntity() -> AuthResult {
        return AuthResult(result: state == "SUCCESS" ? true : false, resultSet: resultSet)
    }
}
