//
//  FirebaseManager.swift
//  DevStack
//
//  Created by Petr Chmelar on 21/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

public protocol HasFirebaseManager {
    var firebaseManager: FirebaseManager { get }
}

public class FirebaseManager: NSObject {

    func start(for application: UIApplication, appDelegate: AppDelegate) {
        // Start Firebase
        FirebaseApp.configure()
        
        // Setup APNs
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        UNUserNotificationCenter.current().delegate = appDelegate
        Messaging.messaging().delegate = appDelegate
        application.registerForRemoteNotifications()
    }
    
    func handleNotification(_ notification: [AnyHashable : Any], appDelegate: AppDelegate) {
        #if DEBUG
        print(notification)
        #endif
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        flowController.dependencies.firebaseManager.handleNotification(notification.request.content.userInfo, appDelegate: self)

        // Show system notification
        completionHandler([.alert, .badge, .sound])
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.flowController.dependencies.firebaseManager.handleNotification(userInfo, appDelegate: self)
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        #if DEBUG
        print("FirebaseMessaging registration token: \(fcmToken)")
        #endif
    }
}
