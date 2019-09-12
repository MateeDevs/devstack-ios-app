//
//  String+UIExtensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

extension String {
    
    public var secured: String {
        return String(map { _ in return "*" })
    }
    
    public var initials: String {
        let words: [Substring] = split(separator: " ")
        let initials = words.map({String($0.first ?? Character(""))})
        let userInitials = initials.joined()
        return userInitials
    }
    
    public func toDate(dateFormat: String = DateFormat.ddMMyyyyHHmm.rawValue) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
}
