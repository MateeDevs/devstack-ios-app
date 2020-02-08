//
//  MainFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 13/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

protocol MainFlowControllerDelegate: class {
    func presentOnboarding()
}

class MainFlowController: FlowController, ProfileFlowControllerDelegate {
    
    weak var delegate: MainFlowControllerDelegate?
    
    override func setup() -> UIViewController {
        let main = MainTabBarController.instantiate()
        
        let usersNc = UINavigationController()
		usersNc.tabBarItem = UITabBarItem(title: L10n.bottom_bar_item_1, image: Asset.Images.contactsTabBar.image, tag: 0)
        let usersFc = UsersFlowController(navigationController: usersNc, dependencies: dependencies)
        let usersRootVc = startChildFlow(usersFc)
        usersNc.viewControllers = [usersRootVc]
        
        let profileNc = UINavigationController()
		profileNc.tabBarItem = UITabBarItem(title: L10n.bottom_bar_item_2, image: Asset.Images.profileTabBar.image, tag: 1)
        let profileFc = ProfileFlowController(navigationController: profileNc, dependencies: dependencies)
        profileFc.delegate = self
        let profileRootVc = startChildFlow(profileFc)
        profileNc.viewControllers = [profileRootVc]
        
        main.viewControllers = [usersNc, profileNc]
        navigationController.navigationBar.isHidden = true
        return main
    }
    
    func presentOnboarding() {
        navigationController.viewControllers = []
        stopFlow()
        delegate?.presentOnboarding()
    }
}
