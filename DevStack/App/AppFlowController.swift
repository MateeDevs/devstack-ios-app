//
//  AppFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class AppFlowController: FlowController, OnboardingFlowControllerDelegate, ProfileFlowControllerDelegate {
    
    override func start() {
        super.start()
        if KeychainStore.get(key: KeychainCoding.userId) != nil {
            setupMain()
        } else {
            presentOnboarding()
        }
    }
    
    func setupMain() {
        let main = MainTabBarController.instantiate()
        
        let usersNc = UINavigationController()
        usersNc.tabBarItem = UITabBarItem(title: L10n.bottomBarItem1, image: Asset.Images.contactsTabBar.image, tag: 0)
        let usersFc = UsersFlowController(navigationController: usersNc, dependencies: dependencies)
        startChildFlow(usersFc)
        
        let profileNc = UINavigationController()
        profileNc.tabBarItem = UITabBarItem(title: L10n.bottomBarItem2, image: Asset.Images.profileTabBar.image, tag: 1)
        let profileFc = ProfileFlowController(navigationController: profileNc, dependencies: dependencies)
        profileFc.delegate = self
        startChildFlow(profileFc)
        
        main.viewControllers = [usersNc, profileNc]
        navigationController.navigationBar.isHidden = true
        navigationController.viewControllers = [main]
    }
    
    func presentOnboarding() {
        let nc = UINavigationController()
        let fc = OnboardingFlowController(navigationController: nc, dependencies: dependencies)
        navigationController.present(nc, animated: true, completion: nil)
        fc.delegate = self
        startChildFlow(fc)
    }
}
