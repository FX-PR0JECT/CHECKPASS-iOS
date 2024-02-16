//
//  AuthRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/8/24.
//

import Combine

protocol AuthRepository {
    func fetchPostResponse(params: Dictionary<String, String>?, for classification: PostRequestUrl) -> AnyPublisher<APIResult, Error>
    func fetchGetResponse(url: String) -> AnyPublisher<APIResult, Error>
}
