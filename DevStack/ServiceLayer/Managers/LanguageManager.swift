//
//  LanguageManager.swift
//  DevStack
//
//  Created by Petr Chmelar on 30/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

public enum Language: String {
    case ar,cs,en,sk
    
    public var fullName: String {
        NSLocalizedString("language_\(rawValue)_fullname", comment: "")
    }
}

private enum LanguageManagerCoding: String {
    case selectedLanguage
}

/// Language manager to handle app language change
/// - Idea taken from [LanguageManager-iOS](https://github.com/Abedalkareem/LanguageManager-iOS)
public class LanguageManager {
    
    /// Returns the singleton LanguageManager instance
    public static let shared: LanguageManager = LanguageManager()
    
    /// Returns the selected language
    public var selectedLanguage: Language {
        get {
            guard
                let savedLanguage = UserDefaultsStore.get(.selectedLanguage) as String?,
                let language = Language(rawValue: savedLanguage) else {
                    Logger.info("LanguageManager: Default language not set, fallback to english applied.", category: .app)
                    return .en
            }
            return language
        }
        set {
            UserDefaultsStore.save(.selectedLanguage, value: newValue.rawValue)
        }
    }
    
    /// Returns the direction of the language
    public var isRightToLeft: Bool {
        selectedLanguage == .ar ? true : false
    }
    
    /// Returns the app locale for use in dates and currencies
    public var appLocale: Locale {
        Locale(identifier: selectedLanguage.rawValue)
    }
    
    /// Set the default language that the app will run first time
    public func setDefaultLanguage(_ language: Language) {
        guard UserDefaultsStore.get(.selectedLanguage) == nil else { return }
        selectedLanguage = language
    }
    
    /// Change language (and kill the app)
    /// - Uses undocumented API and should not be used unless explicitly required by a client
    public func setLanguage(_ language: Language) {
        selectedLanguage = language
        UserDefaults.standard.set([language.rawValue], forKey: "AppleLanguages")
        exit(EXIT_SUCCESS)
    }
    
}
