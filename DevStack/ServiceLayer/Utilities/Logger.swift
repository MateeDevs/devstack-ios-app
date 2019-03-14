//
//  Logger.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//
// Define log categories
// Taken from: https://github.com/AckeeCZ/iOS-MVVM-ProjectTemplate
//

import Foundation
import os.log

/// Contains pre-defined OSLog categories
private struct LoggerCategory {
    /// Generic app logging category
    static var app: String { return "App" }
    /// Networking logging category
    static var networking: String { return "Networking" }
    /// Lifecycle logging category
    static var lifecycle: String { return "Lifecycle" }
}

/// Wrapper class for os_log function
public struct Logger {
    /// Create OSLog with subsystem and category
    public static func osLog(subsystem: String = Bundle.main.bundleIdentifier ?? "-", category: String) -> OSLog {
        return OSLog(subsystem: subsystem, category: category)
    }
    
    /// Create app log
    public static func appLog() -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: LoggerCategory.app)
    }
    
    /// Create networking log
    public static func networkingLog() -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: LoggerCategory.networking)
    }
    
    /// Create lifecycle log
    public static func lifecycleLog() -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: LoggerCategory.lifecycle)
    }
}
