//
//  DTO.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

struct AuthResponseDTO: Codable {
    var state: String
    var code: Int
    var title: String
    var resultSet: String
    
    func toEntity() -> AuthResult {
        return AuthResult(result: state == "SUCCESS" ? true : false, resultSet: resultSet)
    }
}
