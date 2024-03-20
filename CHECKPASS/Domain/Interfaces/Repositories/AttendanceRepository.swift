//
//  AttendanceRepository.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/19/24.
//

import Combine

protocol AttendanceRepository {
    func attend(with params: Dictionary<String, Int>?, to url: String) -> AnyPublisher<APIResult, Error>
    func attendUsingBeacon(to url: String) -> AnyPublisher<APIResult, Error>
    func attendUsingEAttendance(with params: Dictionary<String, Int>, to url: String) -> AnyPublisher<APIResult, Error>
}

extension AttendanceRepository {
    func attend(with params: Dictionary<String, Int>? = nil, to url: String) -> AnyPublisher<APIResult, Error> {
        if let params = params {
            //for EAttendance
            return attendUsingEAttendance(with: params, to: url)
        } else {
            //for BeaconAttendance
            return attendUsingBeacon(to: url)
        }
    }
}
