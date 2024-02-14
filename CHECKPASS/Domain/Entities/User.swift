//
//  User.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/7/24.
//

import Foundation

protocol User {
    var userId: Int { get }
    var userName: String { get set }
    var userJob: JobType { get }
    var userDepartment: String { get }
    var userCollege: String { get }
}
