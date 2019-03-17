//
//  LocationManager.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 10/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
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
        locationMgr.startUpdatingLocation()
        return locationMgr
    }()
    
    /// Function for observing current location
    public func getCurrentLocation() -> Observable<CLLocation> {
        return locationManager.rx.didUpdateLocations
            .map { locations in
                return locations[0]
            }.filter { location in
                return location.horizontalAccuracy < kCLLocationAccuracyHundredMeters
            }
    }

}
