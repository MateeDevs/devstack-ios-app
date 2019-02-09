//
//  StatusCode.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

struct StatusCode {
    
    // codes 100 - 599 are reserved for HTTP status codes
    
    static let unknown = 0
    static let networkError = 900
    static let realmError = 901
    static let fileError = 902
    static let userDefaultsError = 903
    static let validationError = 904
    
}
