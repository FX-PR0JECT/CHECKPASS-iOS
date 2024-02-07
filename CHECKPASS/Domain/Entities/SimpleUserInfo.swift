//
//  SimpleUser.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/12/24.
//

import Foundation

struct SimpleUserInfo {
    let userId: Int
    let userName: String
    let userDepartment: String
    let jobType: JobType?
}

#if DEBUG
extension SimpleUserInfo {
    static var sampleData: Self {
        return SimpleUserInfo(userId: 1234567, userName: "홍길동",
                              userDepartment: "컴퓨터소프트웨어학과", jobType: .student)
    }
}
#endif
