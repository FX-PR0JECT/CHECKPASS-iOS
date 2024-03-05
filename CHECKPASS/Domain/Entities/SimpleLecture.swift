//
//  Lecture.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/1/24.
//

import Foundation

struct SimpleLecture: Identifiable {
    let id: String    //lecture code
    let name: String    //lecture name
    let professor: String    //responsible professor
    let division: String     //lecture division
}

#if DEBUG
extension SimpleLecture {
    static let sampleData: Dictionary<String, [Self]> = [
        "2023학년도 1학기": [
            SimpleLecture(id: "123456", name: "객체지향설계", professor: "홍길동", division: "1"),
            SimpleLecture(id: "154217", name: "Python 프로그래밍", professor: "이순신", division: "1"),
            SimpleLecture(id: "194728", name: "소프트웨어공학", professor: "신사임당", division: "1")
        ],
        "2024학년도 1학기": [
            SimpleLecture(id: "103834", name: "Java 프로그래밍", professor: "홍길동", division: "1"),
            SimpleLecture(id: "139285", name: "운영체제", professor: "대조영", division: "1")
        ]
    ]
    
    static var sampleDataKeys: [String] {
        return sampleData.keys.sorted(by: { $0 > $1 })
    }
}
#endif
