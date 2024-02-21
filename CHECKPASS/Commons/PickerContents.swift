//
//  PickerContents.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

struct PickerContents {
    static let userTypes: [String] = ["학생", "교수", "교직원"]
    static let grades: [String] = ["1학년", "2학년", "3학년", "4학년"]
    static let dayOrNight: [String] = ["주간", "야간"]
    static let semesters: [String] = ["1학기", "2학기"]
}

enum Grades: String, Identifiable, CaseIterable {
    case freshman = "1학년"
    case sophomore = "2학년"
    case junior = "3학년"
    case senior = "4학년"
    
    var id: Self { self }
}

enum SearchStandard: String, Identifiable, CaseIterable {
    case lectureName = "강의명"
    case profName = "교수명"
    case lectureCode = "강의코드"
    
    var id: Self { self }
}

enum LectureType: String, Identifiable, CaseIterable {
    case requiredLecture = "전필"
    case electiveLecture = "전선"
    case generalEducation = "교양"
    
    var id: Self { self }
}

enum Credit: String, Identifiable, CaseIterable {
    case oneCredit = "1학점"
    case twoCredit = "2학점"
    case threeCredit = "3학점"
    
    var id: Self { self }
}
