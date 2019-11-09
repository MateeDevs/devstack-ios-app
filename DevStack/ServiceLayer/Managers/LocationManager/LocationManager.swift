//
//  LocationManager.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 10/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

public protocol HasLocationManager {
    var locationManager: LocationManager { get }
}

public class LocationManager {
    
    private lazy var locationManager: CLLocationManager = {
        let locationMgr = CLLocationManager()
        locationMgr.requestWhenInUseAuthorization()
        return locationMgr
    }()
    
    /// Check whether the location services are enabled and authorized
    public static func isLocationEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                return false
            }
        } else {
            return false
        }
    }
    
    /// Observe current location
    public func getCurrentLocation(withAccuracy accuracy: CLLocationAccuracy = kCLLocationAccuracyThreeKilometers) -> Observable<CLLocation> {
        return locationManager.rx.didUpdateLocations.map({ locations in
            return locations[0]
        }).filter({ location in
            return location.horizontalAccuracy < accuracy
        }).do(
            onCompleted: { [weak self] in
                self?.locationManager.stopUpdatingLocation()
            },
            onSubscribed: { [weak self] in
                self?.locationManager.startUpdatingLocation()
            },
            onDispose: { [weak self] in
                self?.locationManager.stopUpdatingLocation()
            }
        )
    }

}
