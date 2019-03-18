//
//  LanguageManager.swift
//  DevStack
//
//  Created by Petr Chmelar on 30/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//
// Language manager to handle app language change
// Idea taken from: https://github.com/Abedalkareem/LanguageManager-iOS
//

import Foundation

public enum Language: String {
    case ar,cs,en,sk
    
    public var fullName: String {
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
}

private enum LanguageManagerCoding {
    static let selectedLanguage = "selectedLanguage"
}

public class LanguageManager {
    
    /// Returns the singleton LanguageManager instance
    public static let shared: LanguageManager = LanguageManager()
    
    /// Returns the selected language
    public var selectedLanguage: Language {
        get {
            guard
                let savedLanguage = UserDefaults.standard.string(forKey: LanguageManagerCoding.selectedLanguage),
                let language = Language(rawValue: savedLanguage) else {
                    Logger.info("LanguageManager: Default language not set, fallback to english applied.", category: .app)
                    return .en
            }
            return language
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: LanguageManagerCoding.selectedLanguage)
        }
    }
    
    /// Returns the direction of the language
    public var isRightToLeft: Bool {
        return selectedLanguage == .ar ? true : false
    }
    
    /// Returns the app locale for use in dates and currencies
    public var appLocale: Locale {
        return Locale(identifier: selectedLanguage.rawValue)
    }
    
    /// Set the default language that the app will run first time
    public func setDefaultLanguage(_ language: Language) {
        guard UserDefaults.standard.string(forKey: LanguageManagerCoding.selectedLanguage) == nil else { return }
        selectedLanguage = language
    }
    
    /// Change language (and kill the app)
    public func setLanguage(_ language: Language) {
        selectedLanguage = language
        UserDefaults.standard.set([language.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        exit(EXIT_SUCCESS)
    }
    
}
