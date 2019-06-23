//
//  ServiceError.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

struct ServiceError: LocalizedError {
    
    let statusCode: Int
    let message: String?
    
    init(statusCode: Int, message: String?) {
        self.statusCode = statusCode
        self.message = message
    }
    
    public var errorDescription: String? {
		return message ?? L10n.unknown_error
    }
}
