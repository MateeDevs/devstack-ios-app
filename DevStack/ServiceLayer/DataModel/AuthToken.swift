//
//  AuthToken.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import Foundation

class AuthToken: Codable {
    
    // MARK: API properties
    var userId: String = ""
    var email: String = ""
    var token: String = ""

}
