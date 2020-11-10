//
//  AppTheme.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

public enum AppTheme {

    /// Defines all the colors used in the app in a semantic way
    public enum Colors {
        
        // Main colors
        public static let primaryColor = Asset.Colors.mateeYellow.color
        public static let secondaryColor = Asset.Colors.mateeBlue.color
        
        // Navigation bar
        public static let navBarBackground = Asset.Colors.mateeYellow.color
        public static let navBarTitle = UIColor.white
        
        // Backgrounds
        public static let background = UIColorCompatible.systemBackground
        
        // Separators
        public static let separator = UIColorCompatible.separator
        
        // Labels
        public static let label = UIColorCompatible.label
        public static let headlineLabel = Asset.Colors.mateeYellow.color
        
        // Text fields
        public static let textFieldTitle = UIColor.systemGray
        public static let textFieldBorder = UIColorCompatible.systemGray4
        
        // Placeholders
        public static let placeholder = UIColorCompatible.placeholderText
        
        // Buttons
        public static let primaryButtonBackground = Asset.Colors.mateeYellow.color
        public static let primaryButtonTitle = UIColor.white
        
        public static let secondaryButtonBackground = UIColor.clear
        public static let secondaryButtonTitle = Asset.Colors.mateeYellow.color
        
        // Indicators
        public static let activityIndicator = Asset.Colors.mateeYellow.color
        
        // Alerts
        public static let alertBackgroundInfo = UIColor.systemGray
        public static let alertBackgroundSuccess = UIColor.systemGreen
        public static let alertBackgroundError = UIColor.systemRed
        public static let alertMessage = UIColor.white
    }
    
    /// Defines all the fonts used in the app in a semantic way
    public enum Fonts {
        
        // Labels
        public static let headlineLabel = UIFont.systemFont(ofSize: 28.0, weight: .medium)
        
        // Text fields
        public static let textFieldText = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        public static let textFieldTitle = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        public static let textFieldHint = UIFont.systemFont(ofSize: 10.0, weight: .regular)
        
        // Buttons
        public static let primaryButton = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        
        // Alerts
        public static let alertMessage = UIFont.systemFont(ofSize: 13.0, weight: .medium)
    }
    
}
