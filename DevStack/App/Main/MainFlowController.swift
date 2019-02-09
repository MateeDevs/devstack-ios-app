//
//  MainFlowController.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class MainFlowController: FlowController, OnboardingFlowDelegate {
    
    override func start() {
        if KeychainStore.get(key: KeychainCoding.userId) != nil {
            setupMain()
        } else {
            presentOnboarding()
        }
    }
    
    func setupMain() {
        let main = StoryboardScene.Main.initialScene.instantiate()
        
        let usersNavController = UINavigationController()
        usersNavController.tabBarItem = UITabBarItem(title: L10n.bottomBarItem1, image: Asset.Images.contactsTabBar.image, tag: 0)
        let usersFlowController = UsersFlowController(navigationController: usersNavController, dependencies: dependencies)
        usersFlowController.start()
        
        let profileNavController = UINavigationController()
        profileNavController.tabBarItem = UITabBarItem(title: L10n.bottomBarItem2, image: Asset.Images.profileTabBar.image, tag: 1)
        let profileFlowController = ProfileFlowController(navigationController: profileNavController, dependencies: dependencies)
        profileFlowController.start()
        
        main.viewControllers = [usersNavController, profileNavController]
        navigationController.navigationBar.isHidden = true
        navigationController.viewControllers = [main]
    }
    
    func presentOnboarding() {
        let onboardingNavController = UINavigationController()
        let flowController = OnboardingFlowController(navigationController: onboardingNavController, dependencies: dependencies)
        navigationController.present(onboardingNavController, animated: true, completion: nil)
        flowController.flowDelegate = self
        flowController.start()
    }
}
