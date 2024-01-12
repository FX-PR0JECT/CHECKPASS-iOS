//
//  Repository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/12/24.
//

import Combine

protocol Repository {
    func fetchPostResponse<T: DTO>(params: Dictionary<String, String>, for classification: PostRequestUrl, resultType: T.Type) -> AnyPublisher<Entity, Error>
    func fetchGetResponse<T: DTO>(url: String, resultType: T.Type) -> AnyPublisher<Entity, Error>
}
