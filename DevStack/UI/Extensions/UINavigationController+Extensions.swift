//
//  UINavigationController+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 16/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

extension UINavigationController {

    /// Apply preferredStatusBarStyle when in navigation controller
    /// - Idea taken from [Preferred status bar in navigation controller](https://stackoverflow.com/a/41026726)
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}
