//
//  DefaultLectureSearchRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/21/24.
//

import Combine
import Alamofire

final class DefaultLectureSearchRepository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultLectureSearchRepository: LectureRepository {
    func fetchLectures(url: String) -> AnyPublisher<[LectureInfo], Error> {
        return dataSource.sendGetRequest(url: url, resultType: LectureDTO.self)
            .map { DTO in
                DTO.resultSet.map {
                    LectureInfo(id: $0.lectureCode,
                                lectureName: $0.lectureName,
                                lectureGrade: $0.lectureGrade,
                                lectureKind: $0.lectureKind,
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
