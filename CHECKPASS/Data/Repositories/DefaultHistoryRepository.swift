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
    func fetchLecture(url: String) -> AnyPublisher<History, Error> {
        dataSource.sendGetRequest(url: url, resultType: EnrollmentHistoryDTO.self)
            .map { DTO in
                var result = [String: [SimpleLecture]]()
                
                DTO.resultSet.keys.forEach { key in
                    if let lectures = DTO.resultSet[key] {
                        for lecture in lectures {
                            let simpleLecture = SimpleLecture(id: lecture.lectureCode,
                                                              name: lecture.lectureName,
                                                              professor: lecture.professorName,
                                                              division: lecture.division)
                            
                            if result[key] == nil {
                                result[key] = [simpleLecture]
                            } else {
                                result[key]?.append(simpleLecture)
                            }
                        }
                    }
                }
                
                return result
            }
            .eraseToAnyPublisher()
    }
}
