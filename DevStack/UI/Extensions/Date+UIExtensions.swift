//
//  Date+UIExtensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import Foundation

public enum DateFormat: String {
    case ddMMyyyyHHmm = "dd. MM. yyyy, HH:mm"
    case EEddMMMyyyHHmmZ = "EE, dd MMM yyyy HH:mm Z"
    case ddMMyyyy = "dd. MM. yyyy"
    case HHmm = "HH:mm"
}

extension Date {
    
    public func toString(dateFormat: String = DateFormat.ddMMyyyyHHmm.rawValue) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
