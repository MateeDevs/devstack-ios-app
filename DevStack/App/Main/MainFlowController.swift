//
//  MainFlowController.swift
//  DevStack
//
//  Created by Petr Chmelar on 13/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

protocol MainFlowControllerDelegate: class {
    func presentOnboarding(animated: Bool, completion: (() -> Void)?)
}

class MainFlowController: FlowController, ProfileFlowControllerDelegate {
    
    weak var delegate: MainFlowControllerDelegate?
    
    override func setup() -> UIViewController {
        let main = MainTabBarController.instantiate()
        
        let usersNC = UINavigationController()
		usersNC.tabBarItem = UITabBarItem(title: L10n.bottom_bar_item_1, image: Asset.Images.usersTabBar.image, tag: 0)
        let usersFC = UsersFlowController(navigationController: usersNC, dependencies: dependencies)
        let usersRootVC = startChildFlow(usersFC)
        usersNC.viewControllers = [usersRootVC]
        
        let profileNC = UINavigationController()
		profileNC.tabBarItem = UITabBarItem(title: L10n.bottom_bar_item_2, image: Asset.Images.profileTabBar.image, tag: 1)
        let profileFC = ProfileFlowController(navigationController: profileNC, dependencies: dependencies)
        profileFC.delegate = self
        let profileRootVC = startChildFlow(profileFC)
        profileNC.viewControllers = [profileRootVC]

        let counterNC = UINavigationController()
        counterNC.tabBarItem = UITabBarItem(title: L10n.bottom_bar_item_3, image: Asset.Images.counterTabBar.image, tag: 2)
        let counterFC = CounterFlowController(navigationController: counterNC, dependencies: dependencies)
        let counterRootVC = startChildFlow(counterFC)
        counterNC.viewControllers = [counterRootVC]
        
        main.viewControllers = [usersNC, profileNC, counterNC]
        return main
    }
    
    func presentOnboarding() {
        delegate?.presentOnboarding(animated: true, completion: { [weak self] in
            self?.navigationController.viewControllers = []
            self?.stopFlow()
        })
    }
    
    @discardableResult private func switchTab(_ index: MainTab) -> FlowController? {
        guard let tabController = rootViewController as? MainTabBarController,
            let tabs = tabController.viewControllers, index.rawValue < tabs.count else { return nil }
        tabController.selectedIndex = index.rawValue
        return childControllers[index.rawValue]
    }
    
    func handleDeeplink(for notification: PushNotification) {
        switch notification.type {
        case .userDetail:
            handleUserDetailDeeplink(userId: notification.entityId)
        default:
            return
        }
    }
    
    private func handleUserDetailDeeplink(userId: String) {
        guard let usersFlowController = switchTab(.users) as? UsersFlowController else { return }
        usersFlowController.showUserDetail(userId: userId)
    }
}
