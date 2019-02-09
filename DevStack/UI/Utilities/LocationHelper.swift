//
//  Helper.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 30/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class Helper: NSObject {
    class func getCountryAndCodes(sortedbyCountryName: Bool) -> [(text: String, data: AnyObject?)] {
        var countryAndCodes: [(text: String, data: AnyObject?)] = []
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: LanguageManager.shared.selectedLanguage.rawValue).displayName(forKey: NSLocale.Key.identifier, value: id) ?? code
            countryAndCodes.append((text: name, data: code as AnyObject?))
        }
        
        if sortedbyCountryName {
            countryAndCodes = countryAndCodes.sorted(by: {$0.text < $1.text})
        }
        
        return countryAndCodes
    }
    
    class func getCountryBy(code: String) -> String? {
        // Convert ISO country code to full country name
        let currentLocale = NSLocale(localeIdentifier: LanguageManager.shared.selectedLanguage.rawValue)
        let countryName = currentLocale.displayName(forKey: NSLocale.Key.countryCode, value: code)
        return countryName
    }
}
