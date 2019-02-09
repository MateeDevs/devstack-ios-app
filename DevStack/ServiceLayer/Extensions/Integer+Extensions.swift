//
//  Integer+Ex.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 10/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

struct Number {
    static let separator : String = {
        return "\u{2008}"
    }()
    static let formatterWithSepator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = separator
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var stringFormatedWithSepator: String {
        return Number.formatterWithSepator.string(from: NSNumber(value: self)) ?? ""
    }
}
