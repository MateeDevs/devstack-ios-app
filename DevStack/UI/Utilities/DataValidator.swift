//
//  DataValidator.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 02/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

public struct DataValidator {

    ///
    /// Checks whether a given email is valid
    ///
    /// - parameter value: Email to be checked
    /// - returns: True or false
    ///
    public static func validateEmail(_ value: String?) -> Bool {
        guard let email = value else { return false }
        do {
            let regex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: [NSRegularExpression.Options.caseInsensitive])
            return regex.firstMatch(in: email, options: [], range: NSMakeRange(0, email.count)) != nil
        } catch _ as NSError {
            return false
        }
    }
    
}
