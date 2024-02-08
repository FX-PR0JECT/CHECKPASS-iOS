//
//  DefaultUserRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/17/24.
//

import Combine
import Foundation

final class DefaultUserRepository {
    let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
}

extension DefaultUserRepository: UserRepository {    
    func fetchSimpleUserInfo(url: String) -> AnyPublisher<SimpleUserInfo?, Error> {
        return dataSource.sendGetRequest(url: url, resultType: SimpleUserInfoDTO.self)
            .map {
                $0.toEntity()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchDetailedUserInfo(url: String) -> AnyPublisher<User?, Error> {
        return dataSource.sendGetRequest(url: url, resultType: DetailedUserInfoDTO.self)
            .map { DTO in
                guard let job = JobType(rawValue: DTO.resultSet.userJob) else {
                    return nil
                }
                
                switch job {
                case .professor, .staff:
                    return DetailedStaffInfo(userId: DTO.resultSet.userId, userCollege: DTO.resultSet.userCollege,
                                           userDepartment: DTO.resultSet.userDepartment,
                                           userName: DTO.resultSet.userName, hireDate: DTO.resultSet.hiredate ?? "",
                                           userJob: job)
                case .student:
                    return DetailedStudentInfo(userId: DTO.resultSet.userId, userCollege: DTO.resultSet.userCollege,
                                             userDepartment: DTO.resultSet.userDepartment,
                                             userName: DTO.resultSet.userName,
                                             studentGrade: DTO.resultSet.studentGrade ?? "",
                                             dayOrNight: DTO.resultSet.dayOrNight ?? "",
                                             studentSemester: DTO.resultSet.studentSemester ?? "", userJob: job)
                }
            }
            .eraseToAnyPublisher()
    }
}
