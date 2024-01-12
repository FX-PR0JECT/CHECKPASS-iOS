//
//  SignUpResult.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

import Foundation

protocol Entity {}

protocol AuthEntity: Entity {
    var result: Bool { get }
    var resultSet: String { get }
}

struct AuthResult: AuthEntity {
    let result: Bool
    let resultSet: String
}
