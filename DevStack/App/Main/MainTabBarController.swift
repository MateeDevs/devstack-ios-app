//
//  MainTabBarController.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

enum MainTab: Int {
    case users = 0
    case profile = 1
}

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
