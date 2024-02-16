//
//  EditUserInfoUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/15/24.
//

import Combine
import Foundation

protocol EditUserInfoUseCase {
    func execute(data: Dictionary<String, String>, type: JobType) -> AnyPublisher<APIResult, Error>
}

final class DefaultEditUserInfoUseCase {
    enum EditUserInfoError: Error {
        case isIdNil
    }
    
    private let repository: EditUserInfoRepository
    
    init(repository: EditUserInfoRepository) {
        self.repository = repository
    }
}

extension DefaultEditUserInfoUseCase: EditUserInfoUseCase {
    func execute(data: Dictionary<String, String>, type: JobType) -> AnyPublisher<APIResult, Error> {
        guard let userId = UserDefaults.standard.string(forKey: "id") else {
            return Fail<APIResult, EditUserInfoError>(error: .isIdNil)
                .mapError {
                    $0 as Error
                }
                .eraseToAnyPublisher()
        }
        
        let url: String
        
        switch type {
        case .student:
            url = "http://localhost:8080/users/student/\(userId)"
        case .staff, .professor:
            url = "http://localhost:8080/users/professor/\(userId)"
        }
        
        return repository.editUserInfo(url: url, params: data)
                .eraseToAnyPublisher()
    }
}
