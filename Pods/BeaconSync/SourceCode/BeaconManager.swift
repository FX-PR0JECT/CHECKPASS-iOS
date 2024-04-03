import Combine
import CoreLocation

@available(iOS 14.0, *)
class BeaconManager: NSObject, CLLocationManagerDelegate {
    @Published var beacons: [CLBeacon]?
    
    private let locationManager: CLLocationManager
    private let uuid: String
    
    init(for uuid: String) {
        locationManager = CLLocationManager()
        self.uuid = uuid
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
    //MARK: - Stop Beacon scanning
    func stopUpdateLocation() {
        stopMonitoring(for: uuid)
    }
    
    //MARK: - Tells the delegate when the app creates the location manager and when the authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            monitorBeacons()
        }
    }
    
    //MARK: - monioring Beacons
    private func monitorBeacons() {
        
        //check CLLocationManager can monitor CLBeaconRegion
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            //start Monitoring
            startMonitoring(for: uuid)
        } else {
            print("BeaconFlow.monitorBeacons() - CLBeaconRegion can not monitor")
        }
    }

    private func startMonitoring(for uuid: String) {
        guard let uuid = UUID(uuidString: uuid) else {
            fatalError("uuid is not valid")
        }
        
        let beaconRegion = CLBeaconRegion(uuid: uuid, identifier: uuid.uuidString)
        let beaconConstraint = CLBeaconIdentityConstraint(uuid: uuid)
        
        //notify notification when exit region
        beaconRegion.notifyOnExit = true    //call locationManager(_:didExitRegion:)
        //notify notification when enter region
        beaconRegion.notifyOnEntry = true    //call locationManager(_:didEnterRegion:)
        
        self.locationManager.startMonitoring(for: beaconRegion)    //beaconRegion 모니터링 시작
        self.locationManager.startRangingBeacons(satisfying: beaconConstraint)    //beacon 모니터링 시작
    }
    
    private func stopMonitoring(for uuid: String) {
        guard let uuid = UUID(uuidString: uuid) else {
            fatalError("uuid is not valid")
        }
        
        let beaconRegion = CLBeaconRegion(uuid: uuid, identifier: uuid.uuidString)
        let beaconConstraint = CLBeaconIdentityConstraint(uuid: uuid)
        self.locationManager.stopMonitoring(for: beaconRegion)
        self.locationManager.stopRangingBeacons(satisfying: beaconConstraint)
    }
    
    //MARK: - Tells the delegate that the location manager detected at least one beacon that satisfies the provided constraint.
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        //if there are any detected beacons, they are sorted by signal strength
        if beacons.count > 0 {
            self.beacons = beacons
            
            for beacon in beacons {
                switch beacon.proximity {
                case .unknown:
                    //beacon과 사용자의 접근 거리를 정확히 파악할 수 없는 경우
                    print("[\(beacon.major.intValue), \(beacon.minor.intValue)] proximity: unkown")
                case .far:
                    //beacon과 사용자의 접근 거리가 먼 경우
                    print("[\(beacon.major.intValue), \(beacon.minor.intValue)] proximity: far")
                case .near:
                    //beacon과 사용자의 접근 거리가 가까운 경우
                    print("[\(beacon.major.intValue), \(beacon.minor.intValue)] proximity: near")
                case .immediate:
                    //beacon과 사용자가 바로 근처에 있는 경우
                    print("[\(beacon.major.intValue), \(beacon.minor.intValue)] poximity: immediate")
                @unknown case _:
                    //그 외의 데이터가 전달되는 경우
                    print("[\(beacon.major.intValue), \(beacon.minor.intValue)] unkown data")
                }
            }
        } else {
            print("BeaconFlow.locationManager(_:didRange:satisfying:) - CLBeacon not found")
        }
    }
    
    //MARK: - Tells the delegate that the user entered the specified region.
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered range")
    }
    
    //MARK: - Tells the delegate that the user left the specified region.
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("out of range")
    }
}
