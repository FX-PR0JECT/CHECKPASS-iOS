//
//  AttendanceStatuses.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/26/24.
//

import Foundation

struct AttendanceStatuses {
    let firstStatus: AttendanceStatus
    let secondStatus: AttendanceStatus?
    
    var count: Int {
        if let secondStatus {
            return 2
        } else {
            return 1
        }
    }
    
    init(firstStatus: AttendanceStatus, secondStatus: AttendanceStatus? = nil) {
        self.firstStatus = firstStatus
        self.secondStatus = secondStatus
    }
}
