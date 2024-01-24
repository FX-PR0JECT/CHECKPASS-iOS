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
    private let departmentsRepository: DepartmentsRepository
    private let collegesRepository: CollegesRepository
    
    init(departmentsRepository: DepartmentsRepository, collegesRepository: CollegesRepository) {
        self.departmentsRepository = departmentsRepository
        self.collegesRepository = collegesRepository
    }
}

extension DefaultGetDepartmentsUseCase: GetDepartmentsUseCase {
    func executeForColleges() -> AnyPublisher<Colleges, Error> {
        return collegesRepository.fetchColleges()
    }
    
    func executeForDeparments(college: String) -> AnyPublisher<Departments, Error> {
        return departmentsRepository.fetchDepartments(of: college)
    }
}
