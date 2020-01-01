//
//  UIWindow+Extensions.swift
//  DevStack
//
//  Created by Matee on 31/12/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

extension UIWindow {
    convenience init(rootViewController: UIViewController) {
        self.init(frame: UIScreen.main.bounds)
        makeKeyAndVisible()
        self.rootViewController = rootViewController
    }

    static func dismiss(_ window: inout UIWindow?) {
        window?.isHidden = true
        window?.rootViewController = nil
        window = nil
    }
}
