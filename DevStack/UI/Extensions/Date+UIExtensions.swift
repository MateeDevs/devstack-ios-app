//
//  Date+UIExtensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import Foundation

extension Date {
    
    enum DateFormat : String {
        case ddMMyyyyHHmm = "dd. MM. yyyy, HH:mm"
        case EEddMMMyyyHHmmZ = "EE, dd MMM yyyy HH:mm Z"
        case ddMMyyyy = "dd. MM. yyyy"
        case HHmm = "HH:mm"
    }
    
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.ddMMyyyyHHmm.rawValue
        return  formatter.string(from: self)
    }
    
    static func dateFromString(_ stringDate: String, dateFormat: String = DateFormat.EEddMMMyyyHHmmZ.rawValue) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from:stringDate)
        return date
    }
    
    static func stringFromDate(_ date: Date, dateFormat: String = DateFormat.ddMMyyyyHHmm.rawValue) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let string = dateFormatter.string(from: date)
        return string
    }
}
