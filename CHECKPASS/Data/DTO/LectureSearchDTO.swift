// MARK: - SearchLectureDTO
struct LectureSearchDTO: Codable {
    let state: String
    let code: Int
    let title: String
    let resultSet: [LectureSearchResultSet]
}

// MARK: - ResultSet
struct LectureSearchResultSet: Codable {
    let lectureCode: Int
    let lectureName, lectureGrade, lectureKind, lectureGrades: String
    let professorName, lectureRoom: String
    let lectureTimes, alphaTimeCodes: [String]
    let scheduleArray: ResultSetScheduleArray
    let lectureFull, lectureCount: Int
    let dayOrNight, departments, division, yearSemester: String
}

// MARK: - ResultSetScheduleArray
struct ResultSetScheduleArray: Codable {
    let scheduleArray: Dictionary<String, [Bool]>
}
