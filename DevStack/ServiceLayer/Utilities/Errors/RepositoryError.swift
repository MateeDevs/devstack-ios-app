//
//  RepositoryError.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

public struct CommonError {
    public static let realmNotAvailable = RepositoryError(statusCode: .databaseError, message: "Realm isn't available")
    public static let noUserId = RepositoryError(statusCode: .keychainError, message: "Can't retrieve user's id")
}

public struct RepositoryError: LocalizedError {
    
    let statusCode: StatusCode
    let message: String
    
    init(statusCode: StatusCode, message: String) {
        self.statusCode = statusCode
        self.message = message
    }
    
    public var errorDescription: String? {
		message
    }
}
