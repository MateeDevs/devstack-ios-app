//
//  String+UIExtensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    var secured: String {
        get {
            return String(self.map { _ in return "•" })
        }
    }
}
