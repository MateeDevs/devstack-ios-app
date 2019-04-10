//
//  Date+UIExtensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
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

extension Date {
    
    /// Basic conversion from Date to String using native date and time styles.
    public func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        formatter.doesRelativeDateFormatting = true
        return formatter.string(from: self)
    }
    
    /// Conversion from Date to String based on a given template.
    public func toStringWithTemplate(_ template: DateTemplate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: formatter.locale)
        formatter.doesRelativeDateFormatting = true
        return formatter.string(from: self)
    }
    
    /// Conversion from Date to String based on a given date format.   
    /// Please note that this conversion does not respect user's locale/preferences.
    public func toStringWithFormat(_ dateFormat: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.string(from: self)
    }
    
    /// Elapsed time between date and now (nil for future dates).
    /// Converted into localized String "Before xyz days/hours/minutes"
    public var elapsedTimeString: String? {
        let elapsedTime = Date().timeIntervalSince(self)
        if elapsedTime < 0 {
            return nil
        } else if elapsedTime < 60 {
            return L10n.timeEventsNow
        } else if elapsedTime < 60 * 60 {
            return Plurals.minutes_before.stringForCount(Int(ceil(elapsedTime / 60)))
        } else if elapsedTime < 60 * 60 * 24 {
            return Plurals.hours_before.stringForCount(Int(ceil(elapsedTime / (60 * 60))))
        } else {
            return Plurals.days_before.stringForCount(Int(ceil(elapsedTime / (60 * 60 * 24))))
        }
    }
}
