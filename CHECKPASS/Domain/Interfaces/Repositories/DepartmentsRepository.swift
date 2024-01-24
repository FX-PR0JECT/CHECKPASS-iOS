//
//  DepartmentsRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/22/24.
//

import Combine

protocol DepartmentsRepository {
    func fetchDepartments(of college: String) -> AnyPublisher<Departments, Error>
}
