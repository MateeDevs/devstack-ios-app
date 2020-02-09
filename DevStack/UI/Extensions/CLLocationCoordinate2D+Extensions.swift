//
//  CLLocationCoordinate2D+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 10/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {

    /// Conversion from CLLocationCoordinate2D to String.
    public func toString(withPlaces places: Int = 4) -> String {
        return "\(latitude.rounded(toPlaces: places)); \(longitude.rounded(toPlaces: places))"
    }
}
