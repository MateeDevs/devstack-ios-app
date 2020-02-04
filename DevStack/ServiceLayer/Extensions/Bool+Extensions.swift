//
//  Bool+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 12/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

extension Bool {
    
    public func toString() -> String? {
        self ? "true" : "false"
    }
}
