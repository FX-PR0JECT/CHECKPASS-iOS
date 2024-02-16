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
    case signIn = "http://localhost:8080/login"
    case logout = "http://localhost:8080/logout"
}

protocol DataSource {
    func sendPostRequest<DTO: Codable>(_ params: Parameters?, for url: PostRequestUrl, resultType: DTO.Type) -> AnyPublisher<DTO, Error>
    func sendGetRequest<DTO: Codable>(url: String, resultType: DTO.Type) -> AnyPublisher<DTO, Error>
    func sendPatchRequest<DTO: Codable>(url: String, params: Parameters, resultType: DTO.Type) -> AnyPublisher<DTO, Error>
}

final class DefaultDataSource: DataSource {
    //MARK: - request POST API
    func sendPostRequest<DTO: Codable>(_ params: Parameters? = nil, for url: PostRequestUrl, resultType: DTO.Type) -> AnyPublisher<DTO, Error> {
        var dataRequest: DataRequest
        
        if let params = params {
            dataRequest = AF.request(url.rawValue, method: .post,
                                  parameters: params, encoding: JSONEncoding.default)
        } else {
            dataRequest = AF.request(url.rawValue, method: .post)
        }
        
        return dataRequest.publishDecodable(type: resultType)    //decode and return Publisher
                            .value()    //get value
                            .mapError {
                                return $0 as Error
                            }
                            .eraseToAnyPublisher()
    }
    
    //MARK: - request PATCH API
    func sendPatchRequest<DTO: Codable>(url: String, params: Parameters, resultType: DTO.Type) -> AnyPublisher<DTO, Error> {
        return AF.request(url, method: .patch, parameters: params)
                .publishDecodable(type: resultType)
                .value()
                .mapError {
                    $0 as Error
                }
                .eraseToAnyPublisher()
    }
    
    //MARK: - request GET API
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
