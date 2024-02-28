//
//  SignUpResult.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

import Foundation

struct APIResult: Codable {
    var result: Bool
    var code: Int
    var resultSet: String
}
