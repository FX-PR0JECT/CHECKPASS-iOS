//
//  GetLectureByBeaconInfoUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/21/24.
//

import Combine
import Foundation
import CoreLocation

protocol GetLectureByBeaconInfoUseCase {
    func execute(by beacon: CLBeacon) -> AnyPublisher<[Lecture], Error>
}

class DefaultGetLectureByBeaconInfoUseCase<T: LectureRepository> {
    private let repository: T
    
    init(repository: T) {
        self.repository = repository
    }
}

extension DefaultGetLectureByBeaconInfoUseCase: GetLectureByBeaconInfoUseCase {
    func execute(by beacon: CLBeacon) -> AnyPublisher<[Lecture], Error> {
        let major = beacon.major.stringValue
        let minor = beacon.minor.stringValue
//        let publicIP = Bundle.main.publicIP
//        let url = "http://\(publicIP)/lectures/beacon?major=\(major)&minor=\(minor)"
        let domain = Bundle.main.domain
        let url = "\(domain)/lectures/beacon?major=\(major)&minor=\(minor)"
        
        return repository.fetchLectures(url: url)
            .map { lectures in
                guard let lectures = lectures as? [Lecture] else {
                    fatalError("lectures can not be conerted to [Lecture] type")
                }
                
                return lectures
            }
            .eraseToAnyPublisher()
    }
}
