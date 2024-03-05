# BeaconSync

[![CI Status](https://img.shields.io/travis/jeungHunLee/BeaconSync.svg?style=flat)](https://travis-ci.org/jeungHunLee/BeaconSync)
[![Version](https://img.shields.io/cocoapods/v/BeaconSync.svg?style=flat)](https://cocoapods.org/pods/BeaconSync)
[![License](https://img.shields.io/cocoapods/l/BeaconSync.svg?style=flat)](https://cocoapods.org/pods/BeaconSync)
[![Platform](https://img.shields.io/cocoapods/p/BeaconSync.svg?style=flat)](https://cocoapods.org/pods/BeaconSync)

## How to use
```swift
import BeaconSync
import CoreLocation

final class ViewModel: ObservableObject {
    @Published var beacons: [CLBeacon]?
    private var beaconSync: BeaconSync?
    
    func startScann() {
        beaconSync = BeaconSync(for: "00000000-0000-0000-0000-000000000000")
        beaconSync?.sync { [weak self] in
            self?.beacons = $0
        }
    }
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
Swift 5.x <br>
iOS 14.0 ~

## Installation

BeaconSync is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BeaconSync'
```

## Author

jeungHunLee, ksjs1111@gmail.com

## License

BeaconSync is available under the MIT license. See the LICENSE file for more info.
