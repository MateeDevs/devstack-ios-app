//
//  AppDelegate.swift
//  DevStack
//
//  Created by Petr Chmelar on 16/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private(set) var flowController: AppFlowController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if ALPHA
        Logger.info("ALPHA environment", category: .app)
        #elseif BETA
        Logger.info("BETA environment", category: .app)
        #else
        Logger.info("PRODUCTION environment", category: .app)
        #endif

        clearKeychain()
        realmSetup()
        firebaseSetup()
        
        appAppearance()
        LanguageManager.shared.setDefaultLanguage(Language(rawValue: NSLocale.current.languageCode ?? "en") ?? .en)
        
        // Init main window with navigation controller
        let navController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        // Init main flow controller and start the flow
        flowController = AppFlowController(navigationController: navController, dependencies: makeDependencies())
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
    
    // MARK: Clear keychain on first run
    private func clearKeychain() {
        if let hasRunBefore = UserDefaultsStore.get(.hasRunBefore) as Bool?, !hasRunBefore {
            KeychainStore.deleteAll()
            UserDefaultsStore.save(.hasRunBefore, value: true)
        }
    }
    
    // MARK: Dependencies
    private func makeDependencies() -> AppDependency {
        return AppDependency(
            loginService: LoginService(),
            userService: UserService(),
            locationManager: LocationManager()
        )
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
            migrationBlock: { migration, oldSchemaVersion in
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
    private func firebaseSetup() {
        FirebaseApp.configure()
    }
    
    // MARK: Appearance
    private func appAppearance() {
        
        // Navigation bar
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = ColorTheme.mainTheme
        
        // Tab bar
        UITabBar.appearance().tintColor = ColorTheme.mainTheme
        
        // UITextField
        UITextField.appearance().tintColor = ColorTheme.mainTheme
    }
}
