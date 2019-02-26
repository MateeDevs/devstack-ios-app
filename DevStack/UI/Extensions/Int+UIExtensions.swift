//
//  Int+UIExtensions.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 10/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

extension Int {
    
    public func stringFormattedWithSeparator(_ separator: String = "\u{2008}") -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = separator
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
