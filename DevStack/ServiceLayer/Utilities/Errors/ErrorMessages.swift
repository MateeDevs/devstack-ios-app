//
//  ErrorMessages.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/03/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

public struct ErrorMessages {
    
    let statusCodes: [Int: String]
    let defaultMessage: String
    
    init(_ statusCodes: [Int: String], defaultMessage: String) {
        self.statusCodes = statusCodes
        self.defaultMessage = defaultMessage
    }
}
