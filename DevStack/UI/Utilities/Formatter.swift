//
//  Formatter.swift
//  DevStack
//
//  Created by Petr Chmelar on 21/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation

public enum DateTemplate: String {
    case ddMMyyyyHHmm
    case ddMMyyyy
    case HHmm
}

public enum DateFormat: String {
    case ddMMyyyyHHmm = "dd. MM. yyyy, HH:mm"
    case ddMMyyyy = "dd. MM. yyyy"
    case HHmm = "HH:mm"
}

/// Helper for defining global formatters
/// - It is expensive to recreate formatters everytime you need them, so it is a good idea to hold them here
/// - Idea taken from [ChibiCode](http://www.chibicode.org/?p=41)
public struct Formatter {
    
    public static let iso8601 = ISO8601DateFormatter()
    public static let dateDefault = createDateFormatter()
    public static let numberDefault = createNumberFormatter()
    
    /// Creates a DateFormatter based on a given date and time styles.
    public static func createDateFormatter(
        dateStyle: DateFormatter.Style = .medium,
        timeStyle: DateFormatter.Style = .short
    ) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        formatter.doesRelativeDateFormatting = true
        return formatter
    }
    
    /// Creates a DateFormatter based on a given template.
    public static func createDateFormatter(template: DateTemplate) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: formatter.locale)
        formatter.doesRelativeDateFormatting = true
        return formatter
    }
    
    /// Creates a DateFormatter based on a given date format.
    /// - Please note that this conversion does not respect user's locale/preferences.
    public static func createDateFormatter(dateFormat: DateFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter
    }
    
    /// Creates a NumberFormatter based on a given number style.
    public static func createNumberFormatter(
        numberStyle: NumberFormatter.Style = .decimal,
        separator: String? = nil
    ) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = numberStyle
        formatter.groupingSeparator = separator
        return formatter
    }
}
