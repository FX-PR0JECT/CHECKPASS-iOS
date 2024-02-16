//
//  GetDepartmentsUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/22/24.
//

import Combine

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
            return collegesRepository.fetchColleges()
        }
        
        return Fail<Colleges, GetDepartmentsUseCaseError>(error: .collegeRepositoryNil)
            .mapError {
                $0 as Error
            }
            .eraseToAnyPublisher()
    }
    
    func executeForDeparments(college: String) -> AnyPublisher<Departments, Error> {
        return departmentsRepository.fetchDepartments(of: college)
    }
}
