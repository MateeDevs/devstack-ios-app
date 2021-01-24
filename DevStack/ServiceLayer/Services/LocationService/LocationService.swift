//
//  LocationService.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 10/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import CoreLocation
import RxSwift

public protocol HasLocationService {
    var locationService: LocationService { get }
}

public class LocationService {

    typealias Dependencies = HasNoProvider

    init(dependencies: Dependencies) {}
    
    private let locationManager = CLLocationManager()
    
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
    public func getCurrentLocation(
        withAccuracy accuracy: CLLocationAccuracy = kCLLocationAccuracyThreeKilometers
    ) -> Observable<CLLocation> {
        return locationManager.rx.didUpdateLocations
            .map { locations in locations[0] }
            .filter { location in location.horizontalAccuracy < accuracy }
            .do(
                onCompleted: { [weak self] in
                    self?.locationManager.stopUpdatingLocation()
                },
                onSubscribed: { [weak self] in
                    if !LocationService.isLocationEnabled() {
                        self?.locationManager.requestWhenInUseAuthorization()
                    }
                    self?.locationManager.startUpdatingLocation()
                },
                onDispose: { [weak self] in
                    self?.locationManager.stopUpdatingLocation()
                }
            )
    }

}
