//
//  UIImageView+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 27/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

extension UIImageView {

    // Workaround, because extensions must not contain stored properties
    // Idea taken from: https://link.medium.com/6mPz1wuTCU
    private struct Holder {
        static var _rounded: Bool = false
    }
    
    public var rounded: Bool {
        get {
            return Holder._rounded
        }
        set(newValue) {
            Holder._rounded = newValue
            layer.borderWidth = 0
            layer.masksToBounds = newValue ? false : true
            layer.cornerRadius = newValue ? frame.height / 2 : 0
            clipsToBounds = newValue
        }
    }
    
}
