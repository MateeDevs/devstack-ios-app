//
//  DataValidator.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 02/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

public struct DataValidator {

    ///
    /// Checks whether a given email is valid
    ///
    /// - parameter email: Email to be checked
    /// - returns: True or false
    ///
    public static func validateEmail(_ email: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: [NSRegularExpression.Options.caseInsensitive])
            return regex.firstMatch(in: email, options: [], range: NSMakeRange(0, email.count)) != nil
        } catch _ as NSError {
            return false
        }
    }
    
    ///
    /// Checks whether a given password meets requirements
    ///
    /// - parameter password: Password to be checked
    /// - parameter length: Minimum required length
    /// - parameter lowercase: Specify whether at least one lowercase letter is required
    /// - parameter uppercase: Specify whether at least one uppercase letter is required
    /// - parameter number: Specify whether at least one number is required
    /// - parameter special: Specify whether at least one special character is required
    /// - returns: Error message, nil in case of valid password
    ///
    public static func validatePassword(_ password: String, length: Int = 8,
                                        lowercase: Bool = false, uppercase: Bool = false,
                                        number: Bool = false, special: Bool = false) -> String? {
        if password.count < 8 {
            return L10n.password_validation_length
        } else if lowercase, password.range(of: #"[a-z]"#, options: .regularExpression) == nil {
            return L10n.password_validation_lowercase
        } else if uppercase, password.range(of: #"[A-Z]"#, options: .regularExpression) == nil {
            return L10n.password_validation_uppercase
        } else if number, password.range(of: #"[0-9]"#, options: .regularExpression) == nil {
            return L10n.password_validation_number
        } else if special, password.range(of: #"[!&^%$#@()/]"#, options: .regularExpression) == nil {
            return L10n.password_validation_symbol
        } else {
            return nil
        }
    }
    
}
