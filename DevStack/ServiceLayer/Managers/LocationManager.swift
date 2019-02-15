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
    var locationManager: LocationManager { mutating get }
}

public struct LocationManager {
    
    private var locationManager: CLLocationManager = {
        let locationMgr = CLLocationManager()
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.startUpdatingLocation()
        return locationMgr
    }()
    
    public lazy var currentLocation = locationManager.rx.didUpdateLocations
        .map { locations in
            return locations[0]
        }
        .filter { location in
            return location.horizontalAccuracy < kCLLocationAccuracyHundredMeters
        }.take(1)
    
}
