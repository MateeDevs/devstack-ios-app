//
//  LocationManager.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 10/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

struct LocationManager {
    
    var locationManager : CLLocationManager = {
        let locationMgr = CLLocationManager()
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.startUpdatingLocation()
        return locationMgr
    }()
    
    lazy var currentLocation = locationManager.rx.didUpdateLocations
        .map { locations in
            return locations[0]
        }
        .filter { location in
            return location.horizontalAccuracy < kCLLocationAccuracyHundredMeters
        }.take(1)
    
}
