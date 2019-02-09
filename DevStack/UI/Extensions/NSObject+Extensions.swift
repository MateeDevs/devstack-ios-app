//
//  NSObject+Extensions.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 25/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// class name literal
    public class var nameOfClass: String {
        get {
            guard let className = NSStringFromClass(self).components(separatedBy: ".").last else {
                return "N/A"
            }
            return className
        }
    }
}
