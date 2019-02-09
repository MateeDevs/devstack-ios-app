//
//  Plurals.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 20/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

enum Plurals: String {
    case days
    case days_before
    case hours
    case hours_before
    case minutes
    case minutes_before
    case seconds
    case meters
    case points
    
    func stringForCount(_ count: Int) -> String {
        if count == 0 {
            return String(format: NSLocalizedString("zero_\(self.rawValue)", comment: ""), count)
        } else if abs(count) == 1 {
            return String(format: NSLocalizedString("one_\(self.rawValue)", comment: ""), count)
        } else if abs(count) > 1 && abs(count) < 5 {
            return String(format: NSLocalizedString("few_\(self.rawValue)", comment: ""), count)
        } else if abs(count) >= 5 {
            return String(format: NSLocalizedString("many_\(self.rawValue)", comment: ""), count)
        } else {
            return String(format: NSLocalizedString("other_\(self.rawValue)", comment: ""), count)
        }
    }
}
