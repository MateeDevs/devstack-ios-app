//
//  DataValidator.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 02/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class DataValidator: NSObject {

    // Email validation
    class func validateEmail(value: String?) -> Bool {
        guard let email = value else {
            return false
        }
        
        do {
            let regex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: [NSRegularExpression.Options.caseInsensitive])
            return regex.firstMatch(in: email, options: [], range: NSMakeRange(0, email.count)) != nil
        } catch _ as NSError {
            return false
        }
    }
    
}
