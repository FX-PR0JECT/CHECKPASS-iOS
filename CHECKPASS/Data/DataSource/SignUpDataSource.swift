//
//  SignUpDataSource.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

import Alamofire
import Combine

protocol SignUpDataSource {
    func sendRegistrationData(_ params: Parameters) -> AnyPublisher<SignUpResponseDTO, Error>
}

final class DefaultSignUpDataSource: SignUpDataSource {
    private let url: String = ""    //API url
    
    //MARK: - API Request
    func sendRegistrationData(_ params: Parameters) -> AnyPublisher<SignUpResponseDTO, Error> {
        return AF.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default)
                    .publishDecodable(type: SignUpResponseDTO.self)    //decode and return Publisher
                    .value()    //get value
                    .mapError {
                        return $0 as Error
                    }
                    .eraseToAnyPublisher()
    }
}
