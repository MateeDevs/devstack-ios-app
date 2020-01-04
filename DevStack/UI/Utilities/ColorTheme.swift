//
//  ColorTheme.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

/// Helper for  app wide used colors.
public struct ColorTheme {
    
    // Main colors
    public static var primaryColor: UIColor { return Asset.Colors.mateeYellow.color }
    public static var secondaryColor: UIColor { return Asset.Colors.mateeBlue.color }
    
    // Navigation bar
    public static var navBarBackground: UIColor { return Asset.Colors.mateeYellow.color }
    public static var navBarTitle: UIColor { return .white }
    
    // Backgrounds
    public static var background: UIColor { return UIColorCompatible.systemBackground }
    
    // Separators
    public static var separator: UIColor { return UIColorCompatible.separator }
    
    // Labels
    public static var label: UIColor { return UIColorCompatible.label }
    public static var headlineLabel: UIColor { return Asset.Colors.mateeYellow.color }
    
    // Text fields
    public static var textFieldHint: UIColor { return .systemGray }
    public static var textFieldBorder: UIColor { return UIColorCompatible.systemGray4 }
    
    // Placeholders
    public static var placeholder: UIColor { return UIColorCompatible.placeholderText }
    
    // Buttons
    public static var primaryButtonBackground: UIColor { return Asset.Colors.mateeYellow.color }
    public static var primaryButtonTitle: UIColor { return .white }
    
    public static var secondaryButtonBackground: UIColor { return .clear }
    public static var secondaryButtonTitle: UIColor { return Asset.Colors.mateeYellow.color }
    
    // Indicators
    public static var activityIndicator: UIColor { return Asset.Colors.mateeYellow.color }
    
    // Alerts
    public static var alertBackgroundInfo: UIColor { return .systemGray }
    public static var alertBackgroundSuccess: UIColor { return .systemGreen }
    public static var alertBackgroundError: UIColor { return .systemRed }
    public static var alertMessage: UIColor { return .white }
}
