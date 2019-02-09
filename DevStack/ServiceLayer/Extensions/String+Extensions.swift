//
//  String+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
    
    func iso8601(dateFormat: String = NetworkingConstants.iso8601DefaultFormat, timeZone: TimeZone? = TimeZone.current) -> Date {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        if let date = formatter.date(from: self) {
            return date
        } else {
            return Date()
        }
    }
}
