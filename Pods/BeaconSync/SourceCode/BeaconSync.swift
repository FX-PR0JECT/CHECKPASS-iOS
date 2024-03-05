import Combine
import CoreLocation

@available(iOS 14.0, *)
public struct BeaconSync {
    private let beaconManager: BeaconManager
    private var cancellables = Set<AnyCancellable>()
    
    public init(for uuid: String) {
        beaconManager = BeaconManager(for: uuid)
    }
    
    public mutating func sync(completion: @escaping ([CLBeacon]?) -> ()) {
        beaconManager.$beacons
            .sink(receiveValue: {
                completion($0)
            })
            .store(in: &cancellables)
    }
}
