//
//  EditUserInfoRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/15/24.
//

import Combine

protocol EditUserInfoRepository {
    func editUserInfo(url: String, params: Dictionary<String, String>) -> AnyPublisher<APIResult, Error>
}
