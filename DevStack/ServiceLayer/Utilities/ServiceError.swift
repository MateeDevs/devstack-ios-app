//
//  ServiceError.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

class ServiceError: Error, Codable {
    
    var statusCode: Int = StatusCode.unknown
    var message: String = L10n.unknownError
    
    public enum CodingKeys: String, CodingKey {
        case message
    }
    
    init(statusCode: Int = StatusCode.unknown, message: String = L10n.unknownError) {
        self.statusCode = statusCode
        self.message = message
    }
}
