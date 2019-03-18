//
//  LceErrors.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/03/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import Foundation

struct LceErrors {
    
    let messages: [Int: String]
    let defaultMessage: String
    
    init(messages: [Int: String], defaultMessage: String) {
        self.messages = messages
        self.defaultMessage = defaultMessage
    }
}
