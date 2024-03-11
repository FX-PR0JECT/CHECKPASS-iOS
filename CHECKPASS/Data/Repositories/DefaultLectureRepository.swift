//
//  DefaultLectureRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/21/24.
//

import Combine
import Alamofire

final class DefaultLectureRepository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultLectureRepository: LectureRepository {
    func fetchLectures(url: String) -> AnyPublisher<[Lecture], Error> {
        return dataSource.sendGetRequest(url: url, resultType: LectureDTO.self)
            .map { DTO in
                DTO.resultSet.map {
                    Lecture(id: $0.lectureCode,
                                lectureName: $0.lectureName,
                                lectureKind: $0.lectureKind,
                                lectureGrade: $0.lectureGrade,
                                lectureGrades: $0.lectureGrades,
                                professorName: $0.professorName,
                                lectureRoom: $0.lectureRoom,
                                alphaTimeCodes: $0.alphaTimeCodes.joined(separator: "\n"),
                                lectureTimes: $0.lectureTimes,
                                lectureFull: $0.lectureFull,
                                lectureCount: $0.lectureCount,
                                dayOrNight: $0.dayOrNight == "day" ? "주간" : "야간",
                                departments: $0.departments,
                                division: $0.division,
                                yearSemester: $0.yearSemester)
                }
            }
            .eraseToAnyPublisher()
            
    }
}
