//
//  PushNotificationsRepository.swift
//  DevStack
//
//  Created by Petr Chmelar on 21/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Firebase
import UIKit
import UserNotifications

public protocol HasPushNotificationsRepository {
    var pushNotificationsRepository: PushNotificationsRepository { get }
}

public class PushNotificationsRepository: NSObject {

    typealias Dependencies = HasNoProvider

    init(dependencies: Dependencies) {}

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
            Logger.info("PushNotificationsRepository: Notification with type=%d received", notification.type.rawValue, category: .networking)
            appDelegate.flowController?.handleDeeplink(for: notification)
        } catch let error {
            Logger.error("PushNotificationsRepository: Error during notification decoding:\n%@", "\(error)", category: .networking)
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
        DispatchQueue.main.async {
            self.flowController?.dependencies.pushNotificationsRepository.handleNotification(notification, appDelegate: self)
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Logger.debug("PushNotificationsRepository: FirebaseMessaging registration token:\n%@", fcmToken ?? "", category: .networking)
    }
}
