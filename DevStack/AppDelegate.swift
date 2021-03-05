//
//  AppDelegate.swift
//  DevStack
//
//  Created by Petr Chmelar on 16/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit
#if ALPHA || BETA
import Atlantis
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private(set) var flowController: AppFlowController?
    private var providers: ProviderDependency?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        setupEnvironment()
        appAppearance()
        
        // Init main window with navigation controller
        let nc = UINavigationController()
        nc.navigationBar.isHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        // Init main flow controller and start the flow
        flowController = AppFlowController(
            navigationController: nc,
            dependencies: UseCaseDependency(dependencies: RepositoryDependency(dependencies: setupProviders(for: application)))
        )
        flowController?.start()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: Setup environment
    private func setupEnvironment() {
        #if ALPHA
        Atlantis.start()
        UIApplication.environment = Environment(type: .alpha)
        Logger.info("ALPHA environment", category: .app)
        #elseif BETA
        Atlantis.start()
        UIApplication.environment = Environment(type: .beta)
        Logger.info("BETA environment", category: .app)
        #elseif PRODUCTION
        UIApplication.environment = Environment(type: .production)
        Logger.info("PRODUCTION environment", category: .app)
        #endif
    }
    
    // MARK: Setup providers
    private func setupProviders(for application: UIApplication) -> ProviderDependency {
        let databaseProvider = DatabaseProvider()
        let userDefaultsProvider = UserDefaultsProvider()
        let keychainProvider = KeychainProvider(userDefaultsProvider: userDefaultsProvider)
        let networkProvider = NetworkProvider(keychainProvider: keychainProvider, databaseProvider: databaseProvider)
        let pushNotificationsProvider = PushNotificationsProvider(application: application, appDelegate: self)

        return ProviderDependency(
            databaseProvider: databaseProvider,
            keychainProvider: keychainProvider,
            networkProvider: networkProvider,
            pushNotificationsProvider: pushNotificationsProvider,
            userDefaultsProvider: userDefaultsProvider
        )
    }
    
    // MARK: Appearance
    private func appAppearance() {
        
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
