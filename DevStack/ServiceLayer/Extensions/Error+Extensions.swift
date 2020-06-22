//
//  Error+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import Moya

extension Error {
    
    ///
    /// Transformation that tries to map an error to a message based on a given ruleset
    ///
    /// - parameter messages: Ruleset that define messages for status codes
    /// - returns: Error message
    ///
    func toString(_ messages: ErrorMessages) -> String {
        if let validationError = self as? ValidationError {
            return validationError.localizedDescription
        } else if let moyaError = self as? MoyaError,
            let response = moyaError.response,
            let statusCode = StatusCode(rawValue: response.statusCode),
            let message = messages.statusCodes.first(where: { $0.key == statusCode })?.value {
            return message
        } else if let serviceError = self as? ServiceError,
            let message = messages.statusCodes.first(where: { $0.key == serviceError.statusCode })?.value {
            return message
        } else {
            return messages.defaultMessage
        }
    }
}
