//
//  Date+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 30/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

extension Date {

    func iso8601(dateFormat: String = NetworkingConstants.iso8601DefaultFormat, timeZone: TimeZone? = TimeZone.current) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
