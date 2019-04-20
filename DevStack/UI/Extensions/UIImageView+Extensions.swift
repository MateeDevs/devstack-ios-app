//
//  UIImageView+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 27/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public var rounded: Bool {
        get {
            return layer.cornerRadius == frame.height / 2 ? true : false
        }
        set(newValue) {
            layer.cornerRadius = newValue ? frame.height / 2 : 0
            layer.masksToBounds = newValue
            clipsToBounds = newValue
        }
    }
}
