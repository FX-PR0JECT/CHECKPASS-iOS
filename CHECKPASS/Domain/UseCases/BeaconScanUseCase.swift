//
//  BeaconScanUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/5/24.
//

import Combine
import BeaconSync
import CoreLocation

protocol BeaconScanUseCase {
    var beaconSync: BeaconSync? { get }
    
    func abort()
    func execute()
    func subscribeBeacons() -> AnyPublisher<[CLBeacon]?, Never>
}

class DefaultScanBeaconUseCase {
    var beaconSync: BeaconSync?
}

extension DefaultScanBeaconUseCase: BeaconScanUseCase {
    func subscribeBeacons() -> AnyPublisher<[CLBeacon]?, Never> {
        guard let beaconSync else {
            return Just(nil).eraseToAnyPublisher()
        }
        
        return beaconSync.publishBeacons()
    }
    
    func execute() {
        beaconSync = BeaconSync(for: "FE850A83-6660-4792-B2CF-886689B32552")
    }
    
    func abort() {
        beaconSync = nil
    }
}
