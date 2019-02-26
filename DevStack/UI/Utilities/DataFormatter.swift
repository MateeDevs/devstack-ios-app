//
//  DataFormatter.swift
//  DevStack
//
//  Created by Viktor Kaderabek on 12/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

#warning("FIXME: To be refactored")

import UIKit

struct DataFormatter {
    
    ///
    /// Distance label formatting
    ///
    /// - parameter distance: Distance in meters (m)
    /// - parameter rounded: Indicates whether to round distance in kilometers
    /// - returns: Formatted distance label
    ///
    static func formatDistance(from distance: Int, rounded: Bool = false) -> String {
        if distance >= 1000 {
            if LanguageManager.shared.isRightToLeft {
                return rounded ? "km \(Int((CGFloat(distance) / 1000).rounded()))" : "km \(CGFloat(distance) / 1000)"
            } else {
                return rounded ? "\(Int((CGFloat(distance) / 1000).rounded())) km" : "\(CGFloat(distance) / 1000) km"
            }
        } else {
            if LanguageManager.shared.isRightToLeft {
                return "m \(distance)"
            } else {
                return "\(distance) m"
            }
        }
    }
    
    ///
    /// Weight label formatting
    ///
    /// - parameter weight: Weight in kilos (kg)
    /// - parameter rounded: Indicates whether to round weight in tons
    /// - returns: Formatted weight label
    ///
    static func formatWeight(from weight: Int, rounded: Bool = false) -> String {
        if weight >= 1000 {
            if LanguageManager.shared.isRightToLeft {
                return rounded ? "t \(Int((CGFloat(weight) / 1000).rounded()))" : "t \(CGFloat(weight) / 1000)"
            } else {
                return rounded ? "\(Int((CGFloat(weight) / 1000).rounded())) t" : "\(CGFloat(weight) / 1000) t"
            }
        } else {
            if LanguageManager.shared.isRightToLeft {
                return "kg \(weight)"
            } else {
                return "\(weight) kg"
            }
        }
    }
    
    ///
    /// Dimension label formatting
    ///
    /// - parameter dimension: Dimension in milimeters (mm)
    /// - parameter rounded: Indicates whether to round distance
    /// - returns: Formatted dimension label
    ///
    static func formatDimension(from dimension: Int, rounded: Bool = false) -> String {
        if dimension >= 1000 {
            if rounded  {
                return "\(Int((CGFloat(dimension) / 1000).rounded())) m"
            } else {
                return "\(CGFloat(dimension) / 1000) m"
            }
        } else {
            return "\(CGFloat(dimension) / 10) cm"
        }
    }
    
    /// Date label formatting
    ///
    /// - Parameter date: date to format
    /// - Parameter offsetMinutes: time zone offset in minutes to be applied onto date
    /// - Returns: formatted date label
    static func dateStringWording(from date: Date?, offsetMinutes: Int? = nil) -> String? {
        guard let date = date else {
            return nil
        }

        let now = Date().addingTimeInterval(Double(offsetMinutes ?? 0) * 60)

        // if today
        if Calendar.current.compare(now, to: date, toGranularity: .day) == .orderedSame {
            return L10n.todayText
        } else if Calendar.current.compare(now.addingTimeInterval(60*60*24), to: date, toGranularity: .day) == .orderedSame {
            return L10n.tomorrowText
        } else {
            if let offsetMinutes = offsetMinutes {
                return date.iso8601(dateFormat: DateFormat.ddMMyyyy.rawValue, timeZone: TimeZone(secondsFromGMT: offsetMinutes*60))
            } else {
                return date.iso8601(dateFormat: DateFormat.ddMMyyyy.rawValue)
            }
        }
    }
    
    /// Time label formatting
    ///
    /// - Parameter date: time to format
    /// - Parameter offsetMinutes: time zone offset in minutes to be applied onto date
    /// - Returns: formatted time label
    static func timeString(from date: Date?, offsetMinutes: Int? = nil) -> String? {
        guard let date = date else {
            return nil
        }
        
        if let offsetMinutes = offsetMinutes {
            return date.iso8601(dateFormat: DateFormat.HHmm.rawValue, timeZone: TimeZone(secondsFromGMT: offsetMinutes*60))
        } else {
            return date.iso8601(dateFormat: DateFormat.HHmm.rawValue)
        }
    }
    
    /// Days difference formatting
    ///
    /// - Parameter date1: date to be compared
    /// - Parameter date2: date to be compared
    /// - Returns: Positive or negative number of days between date1 and date2
    static func numberOfDaysString(from date1: Date?, to date2: Date?, offsetMinutes: Int = 0) -> String? {
        guard let date1 = date1, let date2 = date2 else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: offsetMinutes*60)
        if formatter.calendar.compare(date1, to: date2, toGranularity: .day) == .orderedSame {
            return nil
        } else {
            let timeDiff = Double(date2.timeIntervalSince(date1))
            let daysDiff = abs(timeDiff / (3600 * 24)).rounded(.up)
            if timeDiff.sign == .minus {
                return "-" + Plurals.days.stringForCount(Int(daysDiff))
            } else {
                return "+" + Plurals.days.stringForCount(Int(daysDiff))
            }
        }
    }

    /// Time difference between dates
    ///
    /// - Parameter dateToCompare: date to be compared
    /// - Parameter dateInitial: date to be compared
    /// - Returns: Localized "Before xyz days/hours/minutes"
    static func timeDifferenceString(dateToCompare: Date, dateInitial: Date) -> String {
        let elapsedTime = dateToCompare.timeIntervalSince(dateInitial)
        if (elapsedTime < 60) {
            return L10n.timeEventsNow
        } else if (elapsedTime < 60 * 60) {
            return Plurals.minutes_before.stringForCount(Int(ceil(elapsedTime / 60)))
        } else if (elapsedTime < 60 * 60 * 24) {
            return Plurals.hours_before.stringForCount(Int(ceil(elapsedTime / (60 * 60))))
        } else {
            return Plurals.days_before.stringForCount(Int(ceil(elapsedTime / (60 * 60 * 24))))
        }
    }

    /// Time date string in future
    ///
    /// - Parameter date: date to format
    /// - Parameter offsetMinutes: time zone offset in minutes to be applied onto date
    /// - Returns: Today/Tomorrow with time, otherwise returns only date without time
    static func dateTimeInFutureString(_ date: Date?, offsetMinutes: Int? = nil) -> String? {
        guard let date = date else {
            return nil
        }
        
        let now = Date().addingTimeInterval(Double(offsetMinutes ?? 0) * 60)
        if Calendar.current.compare(now, to: date, toGranularity: .day) == .orderedSame ||
            Calendar.current.compare(now.addingTimeInterval(60*60*24), to: date, toGranularity: .day) == .orderedSame {
            return "\(dateStringWording(from: date, offsetMinutes: offsetMinutes) ?? "") \(timeString(from: date, offsetMinutes: offsetMinutes) ?? "")"
        } else {
            return "\(dateStringWording(from: date, offsetMinutes: offsetMinutes) ?? "")"
        }
    }
    
    /// User initials formatting
    ///
    /// - Parameter fullName: full name
    /// - Returns: initials
    static func userInitials(from fullName: String) -> String {
        let words: [Substring] = fullName.split(separator: " ")
        let initials = words.map({String($0.first ?? Character(""))})
        let userInitials = initials.joined()
        return userInitials
    }
}
