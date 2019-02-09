//
//  LanguageManager.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 30/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

// Language manager to handle app language change

public enum Language: String {
    case ar,cs,en,sk
    
    var fullName: String {
        switch self {
        case .ar:
            return L10n.languageArFullname
        case .cs:
            return L10n.languageCsFullname
        case .en:
            return L10n.languageEnFullname
        case .sk:
            return L10n.languageSkFullname
        }
    }
    
    static let allCases = [ar, cs, en, sk]
    static let allValues = allCases.map({ $0.rawValue })
}

fileprivate enum LanguageManagerCoding {
    static let selectedLanguage = "selectedLanguage"
}

public class LanguageManager {
    
    // Returns the singleton LanguageManager instance
    public static let shared: LanguageManager = LanguageManager()
    
    // Returns the selected language
    public var selectedLanguage: Language {
        get {
            guard let language = UserDefaults.standard.string(forKey: LanguageManagerCoding.selectedLanguage) else {
                fatalError("Did you set the default language for the app ?")
            }
            return Language(rawValue: language)!
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: LanguageManagerCoding.selectedLanguage)
        }
    }
    
    // Returns the direction of the language
    public var isRightToLeft: Bool {
        get {
            return selectedLanguage == .ar ? true : false
        }
    }
    
    // Returns the app locale for use in dates and currencies
    public var appLocale: Locale {
        get {
            return Locale(identifier: selectedLanguage.rawValue)
        }
    }
    
    // Set the default language that the app will run first time
    public func setDefaultLanguage(_ language: Language) {
        guard UserDefaults.standard.string(forKey: LanguageManagerCoding.selectedLanguage) == nil else {
            return
        }
        selectedLanguage = language
    }
    
    // Change language (and kill the app)
    public func setLanguage(_ language: Language) {
        selectedLanguage = language
        UserDefaults.standard.set([language.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        exit(EXIT_SUCCESS)
    }
    
}
