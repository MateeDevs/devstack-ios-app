//
//  String+UIExtensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import Foundation

extension String {
    
    public func secured() -> String {
        return String(map { _ in return "*" })
    }
    
    public func toDate(dateFormat: String = DateFormat.EEddMMMyyyHHmmZ.rawValue) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
}
