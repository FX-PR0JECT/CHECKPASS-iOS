//
//  LectureInfo.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/21/24.
//

import Foundation

struct Lecture: Identifiable {
    let id: Int
    let lectureName, lectureKind: String
    let lectureGrade, lectureGrades: Int
    let professorName, lectureRoom, alphaTimeCodes: String
    let lectureTimes: [String]
    let lectureFull, lectureCount: Int
    let dayOrNight, departments, division, yearSemester: String
    let scheduleArray: Dictionary<String, [Bool]>
}

extension Lecture: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}

#if DEBUG
extension Lecture {
    static var sampleData: Self {
        Lecture(id: 131314,
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
                yearSemester: "1학기",
                scheduleArray: [
                    "월": [
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        true,
                        true,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false
                    ],
                    "화": [
                        true,
                        true,
                        true,
                        true,
                        true,
                        true,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false
                    ]]
        )
    }
    
    static var sampleDataArray: Array<Self> {
        [
            Lecture(id: 131314,
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
                    yearSemester: "1학기",
                    scheduleArray: [
                        "월": [
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            true,
                            true,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false
                        ],
                        "화": [
                            true,
                            true,
                            true,
                            true,
                            true,
                            true,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false
                        ]]
            ),
            Lecture(id: 131315,
                    lectureName: "소프트웨어공학",
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
                    yearSemester: "1학기",
                    scheduleArray: [
                        "목": [
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            true,
                            true,
                            true,
                            true,
                            true,
                            true
                        ]]
            )
        ]
    }
}
#endif
