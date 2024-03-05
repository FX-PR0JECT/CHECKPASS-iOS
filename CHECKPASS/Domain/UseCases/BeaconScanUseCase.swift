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
    var beaconSync: BeaconSync { get }
    
    func execute() -> AnyPublisher<[CLBeacon]?, Never>
}

class DefaultScanBeaconUseCase {
    lazy var beaconSync: BeaconSync = BeaconSync(for: "FE850A83-6660-4792-B2CF-886689B32552")
}

extension DefaultScanBeaconUseCase: BeaconScanUseCase {
    func execute() -> AnyPublisher<[CLBeacon]?, Never> {
        return beaconSync.publishBeacons()
    }
}
