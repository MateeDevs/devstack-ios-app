//
//  AppDelegate.swift
//  DevStack
//
//  Created by Petr Chmelar on 16/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import RealmSwift
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
        
        #if ALPHA
        Atlantis.start()
        Logger.info("ALPHA environment", category: .app)
        #elseif BETA
        Atlantis.start()
        Logger.info("BETA environment", category: .app)
        #elseif PRODUCTION
        Logger.info("PRODUCTION environment", category: .app)
        #endif

        let providers = setupProviders()
        self.providers = providers

        clearKeychain()
        realmSetup()
        
        appAppearance()
        
        // Init main window with navigation controller
        let nc = UINavigationController()
        nc.navigationBar.isHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        // Init main flow controller and start the flow
        flowController = AppFlowController(navigationController: nc, dependencies: RepositoryDependency(dependencies: providers))
        flowController?.start()
        
        firebaseSetup(for: application)
        
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
    
    // MARK: Setup providers
    private func setupProviders() -> ProviderDependency {
        let databaseProvider = DatabaseProvider()
        let keychainProvider = KeychainProvider()
        let networkProvider = NetworkProvider(
            keychainProvider: keychainProvider,
            databaseProvider: databaseProvider
        )
        let userDefaultsProvider = UserDefaultsProvider()

        return ProviderDependency(
            databaseProvider: databaseProvider,
            keychainProvider: keychainProvider,
            networkProvider: networkProvider,
            userDefaultsProvider: userDefaultsProvider
        )
    }
    
    // MARK: Clear keychain on first run
    private func clearKeychain() {
        guard let providers = providers, (providers.userDefaultsProvider.get(.hasRunBefore) as Bool?) == nil else { return }
        providers.keychainProvider.deleteAll()
        providers.userDefaultsProvider.save(.hasRunBefore, value: true)
    }
    
    // MARK: Realm
    private func realmSetup() {
        // Realm BASIC migration setup
        var config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 0,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { _, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if oldSchemaVersion < 1 {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        // Delete old schema
        config.deleteRealmIfMigrationNeeded = true
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    // MARK: Firebase
    private func firebaseSetup(for application: UIApplication) {
        flowController?.dependencies.pushNotificationsRepository.start(for: application, appDelegate: self)
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
