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
    case eAttendance = "http://localhost:8080/attendance"
}

protocol DataSource {
    func sendPostRequest<DTO: Codable>(_ params: Parameters?, for url: PostRequestUrl, resultType: DTO.Type) -> AnyPublisher<DTO, Error>
    func sendPostRequest<DTO: Codable>(url: String, params: Parameters?, resultType: DTO.Type) -> AnyPublisher<DTO, Error>
    func sendGetRequest<DTO: Codable>(url: String, resultType: DTO.Type) -> AnyPublisher<DTO, Error>
    func sendPatchRequest<DTO: Codable>(url: String, params: Parameters, resultType: DTO.Type) -> AnyPublisher<DTO, Error>
    func sendMultipartFormDataRequest<DTO: Codable>(with params: Parameters, to url: String, resultType: DTO.Type) -> AnyPublisher<DTO, Error>
}

extension DataSource {
    //MARK: - request POST API
    func sendPostRequest<DTO: Codable>(_ params: Parameters? = nil, for url: PostRequestUrl, resultType: DTO.Type) -> AnyPublisher<DTO, Error> {
        var dataRequest: DataRequest
        
        if let params = params {
            dataRequest = AF.request(url.rawValue,
                                     method: .post,
                                     parameters: params,
                                     encoding: JSONEncoding.default)
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
    
    //MARK: - request POST API for flexible pathvariable
    func sendPostRequest<DTO: Codable>(url: String, params: Parameters? = nil, resultType: DTO.Type) -> AnyPublisher<DTO, Error> {
        let dataRequest: DataRequest
        
        if let params {
            dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: params,
                                     encoding: JSONEncoding.default)
        } else {
            dataRequest = AF.request(url, method: .post)
        }
        
        return dataRequest
                    .publishDecodable(type: resultType)
                    .value()
                    .mapError {
                        return $0 as Error
                    }
                    .eraseToAnyPublisher()
    }
}

class DefaultDataSource: DataSource {
    //MARK: - request MultiPartFormData API
    func sendMultipartFormDataRequest<DTO: Codable>(with params: Parameters, to url: String, resultType: DTO.Type) -> AnyPublisher<DTO, Error> {
        return AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
        }, to: url)
        .publishDecodable(type: resultType)
        .value()
        .mapError {
            $0 as Error
        }
        .eraseToAnyPublisher()
    }
    
    //MARK: - request PATCH API
    func sendPatchRequest<DTO: Codable>(url: String, params: Parameters, resultType: DTO.Type) -> AnyPublisher<DTO, Error> {
        return AF.request(url, 
                          method: .patch,
                          parameters: params,
                          encoding: JSONEncoding.default)
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
