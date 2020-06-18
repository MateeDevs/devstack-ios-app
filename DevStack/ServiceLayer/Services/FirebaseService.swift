//
//  FirebaseService.swift
//  DevStack
//
//  Created by Petr Chmelar on 21/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Firebase
import UIKit
import UserNotifications

public protocol HasFirebaseService {
    var firebaseService: FirebaseService { get }
}

public class FirebaseService: NSObject {

    func start(for application: UIApplication, appDelegate: AppDelegate) {
        // Start Firebase
        FirebaseApp.configure()
        
        // Setup APNs
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        UNUserNotificationCenter.current().delegate = appDelegate
        Messaging.messaging().delegate = appDelegate
        application.registerForRemoteNotifications()
    }
    
    func handleNotification(_ notificationData: [AnyHashable: Any], appDelegate: AppDelegate) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: notificationData, options: [])
            let notification = try JSONDecoder().decode(PushNotification.self, from: jsonData)
            Logger.info("FirebaseService: Notification with type=%d received", notification.type.rawValue, category: .networking)
            appDelegate.flowController?.handleDeeplink(for: notification)
        } catch let error {
            Logger.error("FirebaseService: Error during notification decoding:\n%@", "\(error)", category: .networking)
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Show system notification
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let notification = response.notification.request.content.userInfo
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.flowController?.dependencies.firebaseService.handleNotification(notification, appDelegate: self)
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        Logger.debug("FirebaseService: FirebaseMessaging registration token:\n%@", fcmToken, category: .networking)
    }
}
