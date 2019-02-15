//
//  UIImageView+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 27/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    
    struct Holder {
        static var _rounded:Bool = false
    }
    
    var rounded: Bool {
        get {
            return Holder._rounded
        }
        set(newValue) {
            Holder._rounded = newValue
            layer.borderWidth = 0
            layer.masksToBounds = newValue ? false : true
            layer.cornerRadius = newValue ? frame.height/2 : 0
            clipsToBounds = newValue
        }
    }
    
}
