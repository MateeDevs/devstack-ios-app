//
//  String+UIExtensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

public extension String {
    
    var secured: String {
        String(map { _ in "*" })
    }
    
    var initials: String {
        let words: [Substring] = split(separator: " ")
        let initials = words.map { String($0.first ?? Character("")) }
        let userInitials = initials.joined()
        return userInitials
    }
    
    /// Conversion from String to Date using a given formatter.
    func toDate(formatter: DateFormatter = Formatter.dateDefault) -> Date? {
        formatter.date(from: self)
    }
}
