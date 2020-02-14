//
//  ServiceError.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

struct CommonError {
    public static let noUserId = ServiceError(statusCode: StatusCode.keychainError, message: "Can't retrieve user's id")
}

struct ServiceError: LocalizedError {

    let statusCode: Int
    let message: String?

    init(statusCode: Int, message: String?) {
        self.statusCode = statusCode
        self.message = message
    }

    public var errorDescription: String? {
		message ?? L10n.unknown_error
    }
}
