//
//  BeaconAttendanceViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/5/24.
//

import Combine
import CoreLocation

protocol BeaconAttendanceViewModel: ObservableObject {
    var beacons: [CLBeacon]? { get }
    
    func startScan()
}

final class DefaultBeaconAttendanceViewModel {
    @Published var beacons: [CLBeacon]?
    
    private let beaconScanUsecase: BeaconScanUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(beaconScanUsecase: BeaconScanUseCase) {
        self.beaconScanUsecase = beaconScanUsecase
        
        //observing beacons property
        $beacons.sink(receiveValue: { beacons in
            //To do when beacons property value is changed
        })
        .store(in: &cancellables)
    }
}

extension DefaultBeaconAttendanceViewModel: BeaconAttendanceViewModel {
    func startScan() {
        beaconScanUsecase.execute()
            .sink(receiveValue: { [weak self] beacons in
                self?.beacons = beacons
            })
            .store(in: &cancellables)
    }
}
