//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

public class AppFlowController: FlowController, MainFlowControllerDelegate, OnboardingFlowControllerDelegate {
    
    public func start() {
        setupAppearance()
        
        if dependencies.getProfileIdUseCase.execute() != nil {
            setupMain()
        } else {
            presentOnboarding(animated: false, completion: nil)
        }
    }
    
    func setupMain() {
        let fc = MainFlowController(navigationController: navigationController, dependencies: dependencies)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        navigationController.navigationBar.barStyle = .black
        navigationController.viewControllers = [rootVC]
    }
    
    func presentOnboarding(animated: Bool, completion: (() -> Void)?) {
        let nc = UINavigationController()
        let fc = OnboardingFlowController(navigationController: nc, dependencies: dependencies)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        nc.viewControllers = [rootVC]
        nc.modalPresentationStyle = .fullScreen
        nc.navigationBar.isHidden = true
        navigationController.present(nc, animated: animated, completion: completion)
    }
    
    func handleDeeplink(for notification: PushNotification) {
        guard let main = childControllers.first(where: { $0 is MainFlowController }) as? MainFlowController else { return }
        main.handleDeeplink(for: notification)
    }
    
    private func setupAppearance() {
        // Navigation bar
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = AppTheme.Colors.navBarTitle
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppTheme.Colors.navBarTitle]
        UINavigationBar.appearance().barTintColor = AppTheme.Colors.navBarBackground

        // Tab bar
        UITabBar.appearance().tintColor = AppTheme.Colors.primaryColor

        // UITextField
        UITextField.appearance().tintColor = AppTheme.Colors.primaryColor
    }
}
