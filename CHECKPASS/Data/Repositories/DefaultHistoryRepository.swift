//
//  DefaultLectureHistoryRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/6/24.
//

import Combine

class DefaultEnrollmentHistoryRepository {
    private let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultEnrollmentHistoryRepository: LectureRepository {
    func fetchLectures(url: String) -> AnyPublisher<History, Error> {
        dataSource.sendGetRequest(url: url, resultType: EnrollmentHistoryDTO.self)
            .map { DTO in
                var result = [String: [Lecture]]()
                
                DTO.resultSet.keys.forEach { key in
                    if let lectures = DTO.resultSet[key] {
                        for lecture in lectures {
                            let lecture = Lecture(id: lecture.lectureCode,
                                                  lectureName: lecture.lectureName,
                                                  lectureKind: lecture.lectureKind,
                                                  lectureGrade: lecture.lectureGrade,
                                                  lectureGrades: lecture.lectureGrades,
                                                  professorName: lecture.professorName,
                                                  lectureRoom: lecture.lectureRoom,
                                                  alphaTimeCodes: lecture.alphaTimeCodes.joined(separator: "\n"),
                                                  lectureTimes: lecture.lectureTimes,
                                                  lectureFull: lecture.lectureFull,
                                                  lectureCount: lecture.lectureCount,
                                                  dayOrNight: lecture.dayOrNight,
                                                  departments: lecture.departments,
                                                  division: lecture.division,
                                                  yearSemester: lecture.yearSemester,
                                                  scheduleArray: lecture.scheduleArray.scheduleArray)
                            
                            if result[key] == nil {
                                result[key] = [lecture]
                            } else {
                                result[key]?.append(lecture)
                            }
                        }
                    }
                }
                
                return result
            }
            .eraseToAnyPublisher()
    }
}
