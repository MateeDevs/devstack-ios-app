//
//  NetworkingConstants.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

struct NetworkingConstants {
    
    static let apiVersion = 1
    
    static let paginationCount = 100
    
    static let thumbnailSize = 512
    
    static let iso8601DefaultFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    static let iso8601DateOnly = "yyyy-MM-dd"
    
    #if ALPHA
    static let baseURL = "https://qest-devstack.herokuapp.com"
    #elseif BETA
    static let baseURL = "https://qest-devstack.herokuapp.com"
    #else
    static let baseURL = "https://qest-devstack.herokuapp.com"
    #endif
    
}
