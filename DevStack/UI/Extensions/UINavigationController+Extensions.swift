//
//  UINavigationController+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 16/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    // Apply preferredStatusBarStyle when in navigation controller
    // Idea taken from: https://stackoverflow.com/q/41026514/6947225
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}
