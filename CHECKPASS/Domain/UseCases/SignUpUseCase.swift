//
//  SignUpUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/2/24.
//

import Combine
import Foundation

enum SignUpType {
    case student
    case staff
}

protocol SignUpUseCase {
    func execute(for type: SignUpType, with data: Dictionary<String, String>, colleges: Colleges?, departments: Departments?) -> AnyPublisher<APIResult, Error>
}

final class DefaultSignUpUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
}

extension DefaultSignUpUseCase: SignUpUseCase {
    func execute(for type: SignUpType, with data: Dictionary<String, String>, colleges: Colleges?, departments: Departments?) -> AnyPublisher<APIResult, Error> {
        //transfer kor name to eng name
        guard let signUpCollege = data["signUpCollege"],
              let engCollege = colleges?[signUpCollege],
              let signUpDepartment = data["signUpDepartment"],
              let engDepartment = departments?[signUpDepartment] else {
            //sign up failed because there is no eng name
            return Just(APIResult(result: false, code: -62, resultSet: "There is no eng name"))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        var replacedData = data
        replacedData["signUpCollege"] = engCollege
        replacedData["signUpDepartment"] = engDepartment
//        let publicIP = Bundle.main.publicIP
        let domain = Bundle.main.domain
        let url: String
        
        switch type {
        case .student:
//            url = "http://\(publicIP)/users/studentSignup"
            url = "\(domain)/users/studentSignup"
        case .staff:
//            url = "http://\(publicIP)/users/professorSignup"
            url = "\(domain)/users/professorSignup"
        }
        
        return repository.requestAuthentication(params: replacedData, to: url)
    }
}
