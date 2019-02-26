//
//  ServiceError.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

public class ServiceError: Error {
    
    public let statusCode: Int
    public let message: String
    
    public init(statusCode: Int = StatusCode.unknown, message: String = L10n.unknownError) {
        self.statusCode = statusCode
        self.message = message
    }
}
