//
//  Array+CLBeacon.swift
//  CHECKPASS
//
//  Created by 이정훈 on 4/10/24.
//

import Foundation
import CoreLocation

extension Array<CLBeacon> {
    func contains(_ target: CLBeacon) -> Bool {
        var result = false
        
        self.forEach { beacon in
            if beacon.major == target.major && beacon.minor == target.minor {
                result = true
            }
        }
        
        return result
    }
}
