//
//  MainTabBarController.swift
//  DevStack
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

enum MainTab: Int {
    case users = 0
    case profile = 1
}

class MainTabBarController: UITabBarController {
    
    static func instantiate() -> MainTabBarController {
        let vc = StoryboardScene.Main.initialScene.instantiate()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
