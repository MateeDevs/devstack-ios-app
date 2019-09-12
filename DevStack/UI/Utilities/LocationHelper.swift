//
//  LocationHelper.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 30/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

public struct LocationHelper {
    
    ///
    /// Countries and ISO codes from system
    ///
    /// - parameter sorted: Sort by country name
    /// - returns: Dictionary with names and ISO codes
    ///
    public static func getCountriesAndCodes(sorted: Bool = true) -> [(text: String, data: AnyObject?)] {
        var countriesAndCodes: [(text: String, data: AnyObject?)] = []
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: LanguageManager.shared.selectedLanguage.rawValue).displayName(forKey: NSLocale.Key.identifier, value: id) ?? code
            countriesAndCodes.append((text: name, data: code as AnyObject?))
        }
        
        return sorted ? countriesAndCodes.sorted(by: {$0.text < $1.text}) : countriesAndCodes
    }
    
    ///
    /// Convert ISO country code to full country name
    ///
    /// - parameter code: ISO code of a country
    /// - returns: Full country name
    ///
    public static func getCountryBy(code: String) -> String? {
        let currentLocale = NSLocale(localeIdentifier: LanguageManager.shared.selectedLanguage.rawValue)
        let countryName = currentLocale.displayName(forKey: NSLocale.Key.countryCode, value: code)
        return countryName
    }
}
