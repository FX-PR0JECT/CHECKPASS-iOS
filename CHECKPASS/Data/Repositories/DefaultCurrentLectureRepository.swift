//
//  DefaultCurrentLectureRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/28/24.
//

import Combine

class DefaultCurrentLectureRepository {
    let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

extension DefaultCurrentLectureRepository: LectureRepository {
    func fetchLecture(url: String) -> AnyPublisher<[SimpleLecture], Error> {
        dataSource.sendGetRequest(url: url, resultType: LectureDTO.self)
            .map { DTO in
                DTO.resultSet.map { lecture in
                    SimpleLecture(id: String(lecture.lectureCode),
                                  name: lecture.lectureName,
                                  professor: lecture.professorName,
                                  division: "1")
                }
            }
            .eraseToAnyPublisher()
    }
}
