//
//  DataSource.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

import Alamofire
import Combine

enum PostRequestUrl: String {
    case signUpForStudent = "http://localhost:8080/users/studentSignup"
    case signUpForStaff = "http://localhost:8080/users/professorSignup"
    case signIn
}

protocol DataSource {
    func sendPostRequest<DTO: Codable>(_ params: Parameters, for url: PostRequestUrl, resultType: DTO.Type) -> AnyPublisher<DTO, Error>
    func sendGetRequest<DTO: Codable>(url: String, resultType: DTO.Type) -> AnyPublisher<DTO, Error>
}

final class DefaultDataSource: DataSource {
    //MARK: - request POST api
    func sendPostRequest<DTO: Codable>(_ params: Parameters, for url: PostRequestUrl, resultType: DTO.Type) -> AnyPublisher<DTO, Error> {
        return AF.request(url.rawValue,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default)
                    .publishDecodable(type: resultType)    //decode and return Publisher
                    .value()    //get value
                    .mapError {
                        return $0 as Error
                    }
                    .eraseToAnyPublisher()
    }
    
    //MARK: - request GET api
    func sendGetRequest<DTO: Codable>(url: String, resultType: DTO.Type) -> AnyPublisher<DTO, Error> {
        return AF.request(url)
                    .publishDecodable(type: resultType)    //decode and return Publisher
                    .value()    //get value
                    .mapError {
                        return $0 as Error
                    }
                    .eraseToAnyPublisher()
    }
}
