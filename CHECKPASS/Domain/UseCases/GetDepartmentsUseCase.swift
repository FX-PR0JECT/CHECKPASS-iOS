//
//  GetDepartmentsUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/22/24.
//

import Combine
import Foundation

protocol GetDepartmentsUseCase {
    func executeForColleges() -> AnyPublisher<Colleges, Error>
    func executeForDeparments(college: String) -> AnyPublisher<Departments, Error>
}

final class DefaultGetDepartmentsUseCase {
    enum GetDepartmentsUseCaseError: Error {
        case collegeRepositoryNil
    }
    
    private let departmentsRepository: DepartmentsRepository
    private let collegesRepository: CollegesRepository?
    
    init(departmentsRepository: DepartmentsRepository, collegesRepository: CollegesRepository? = nil) {
        self.departmentsRepository = departmentsRepository
        self.collegesRepository = collegesRepository
    }
}

extension DefaultGetDepartmentsUseCase: GetDepartmentsUseCase {
    func executeForColleges() -> AnyPublisher<Colleges, Error> {
        if let collegesRepository = collegesRepository {
            let publicIP = Bundle.main.publicIP
            let url = "http://\(publicIP)/viewElement/colleges"
            return collegesRepository.fetchColleges(to: url)
        }
        
        return Fail<Colleges, GetDepartmentsUseCaseError>(error: .collegeRepositoryNil)
            .mapError {
                $0 as Error
            }
            .eraseToAnyPublisher()
    }
    
    func executeForDeparments(college: String) -> AnyPublisher<Departments, Error> {
        let publicIP = Bundle.main.publicIP
        let url = "http://\(publicIP)/viewElement/departments/\(college)"
        return departmentsRepository.fetchDepartments(to: url)
    }
}
