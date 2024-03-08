//
//  LectureInfo.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/21/24.
//

import Foundation

struct LectureInfo: Identifiable {
    let id: Int
    let lectureName, lectureKind: String
    let lectureGrade, lectureGrades: Int
    let professorName, lectureRoom, alphaTimeCodes: String
    let lectureTimes: [String]
    let lectureFull, lectureCount: Int
    let dayOrNight, departments, division, yearSemester: String
}

#if DEBUG
extension LectureInfo {
    static var sampleData: Self {
        LectureInfo(id: 131314,
                    lectureName: "데이터베이스",
                    lectureKind: "전필",
                    lectureGrade: 4,
                    lectureGrades: 3,
                    professorName: "홍길동",
                    lectureRoom: "미래융합정보관(220)",
                    alphaTimeCodes:
                        "월 [1A, 1B, 2A, 2B, 3A],\n화 [2B, 3A, 3B, 4A]",
                    lectureTimes: [
                            "D0T0900H150",
                            "D1T1030H120"
                        ],
                    lectureFull: 40,
                    lectureCount: 0,
                    dayOrNight: "day",
                    departments: "건축공학과 [5년제]",
                    division: "2분반",
                    yearSemester: "1학기")
    }
}
#endif
