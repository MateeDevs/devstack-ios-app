//
//  String+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

extension String {
    
    var utf8Encoded: Data {
        data(using: .utf8)!
    }
    
    func convertFromISO8601(dateFormat: String = NetworkingConstants.iso8601DefaultFormat, timeZone: TimeZone? = TimeZone.current) -> Date {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        guard let date = formatter.date(from: self) else { return Date() }
        return date
    }
}
