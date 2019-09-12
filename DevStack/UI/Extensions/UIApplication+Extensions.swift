//
//  UIApplication+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

extension UIApplication {
    
    @nonobjc static func rootTabBarController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UITabBarController? {
        guard let nav = base as? UINavigationController, let tab = nav.viewControllers.first as? UITabBarController else { return nil }
        return tab
    }
    
    @nonobjc static func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        } else {
            return base
        }
    }
}
