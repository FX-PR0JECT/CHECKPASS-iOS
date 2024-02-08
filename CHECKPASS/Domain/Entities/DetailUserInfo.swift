//
//  DetailUserInfo.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/7/24.
//

import Foundation

struct DetailedStudentInfo: User {
    let userId: Int
    let userCollege, userDepartment, userName: String
    let studentGrade, dayOrNight, studentSemester: String
    let userJob: JobType
}

struct DetailedStaffInfo: User {
    let userId: Int
    let userCollege, userDepartment, userName: String
    let hireDate: String
    let userJob: JobType
}
