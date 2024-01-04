//
//  DTO.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

struct SignUpResponseDTO: Codable {
    var state: String
    var code: String
    var resultSet: String
    
    func toEntity() -> SignUpResult {
        return SignUpResult(result: state == "success" ? true : false)
    }
}
