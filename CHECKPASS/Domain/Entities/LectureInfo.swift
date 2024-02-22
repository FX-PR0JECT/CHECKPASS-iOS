//
//  LectureInfo.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/21/24.
//

import Foundation

struct LectureInfo {
    let lectureCode: Int
    let lectureName, lectureGrade, lectureKind, lectureGrades: String
    let professorName, lectureRoom: String
    let lectureTimes, alphaTimeCodes: [String]
    let lectureFull, lectureCount: Int
    let dayOrNight, departments, division, yearSemester: String
}
