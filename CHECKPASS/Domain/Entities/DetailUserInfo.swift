//
//  DetailUserInfo.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/7/24.
//

import Foundation

struct DetailedStudentInfo: User {
    let userId: Int
    var userCollege, userDepartment, userName: String
    let studentGrade, dayOrNight, studentSemester: String
    let userJob: JobType
}

struct DetailedStaffInfo: User {
    let userId: Int
    var userCollege, userDepartment, userName: String
    let hireDate: String
    let userJob: JobType
}

extension DetailedStudentInfo: Equatable {
    static func == (lhs: DetailedStudentInfo, rhs: DetailedStudentInfo) -> Bool {
        if lhs.userId != rhs.userId { return false }
        
        if lhs.userName != rhs.userName { return false }
        
        if lhs.userCollege != rhs.userCollege { return false }
        
        if lhs.userDepartment != rhs.userDepartment { return false }
        
        if lhs.studentGrade != rhs.studentGrade { return false }
        
        if lhs.studentSemester != rhs.studentSemester { return false }
        
        if lhs.dayOrNight != rhs.dayOrNight { return false }
        
        if lhs.userJob != rhs.userJob { return false }
        
        return true
    }
}

extension DetailedStaffInfo: Equatable {
    static func == (lhs: DetailedStaffInfo, rhs: DetailedStaffInfo) -> Bool {
        if lhs.userId != rhs.userId { return false }
        
        if lhs.userName != rhs.userName { return false }
        
        if lhs.userCollege != rhs.userCollege { return false }
        
        if lhs.userDepartment != rhs.userDepartment { return false }
        
        if lhs.hireDate != rhs.hireDate { return false }
        
        if lhs.userJob != rhs.userJob { return false }
        
        return true
    }
}
