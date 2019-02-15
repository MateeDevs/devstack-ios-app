//
//  StatusCode.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

public struct StatusCode {
    
    // codes 100 - 599 are reserved for HTTP status codes
    
    public static let unknown = 0
    public static let networkError = 900
    public static let realmError = 901
    public static let fileError = 902
    public static let userDefaultsError = 903
    public static let validationError = 904
    
}
