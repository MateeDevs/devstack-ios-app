//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Firebase
import UIKit
import UserNotifications

protocol HasPushNotificationsProvider {
    var pushNotificationsProvider: PushNotificationsProviderType { get }
}

protocol PushNotificationsProviderType {
}

struct PushNotificationsProvider: PushNotificationsProviderType {
    
    init(application: UIApplication, appDelegate: AppDelegate) {
        // Start Firebase
        FirebaseApp.configure()
        
        // Setup APNs
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        UNUserNotificationCenter.current().delegate = appDelegate
        Messaging.messaging().delegate = appDelegate
        application.registerForRemoteNotifications()
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
            guard let notification = self.flowController?.dependencies.handlePushNotificationUseCase.execute(notification) else { return }
            self.flowController?.handleDeeplink(for: notification)
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Logger.debug("PushNotificationsProvider: FirebaseMessaging registration token:\n%@", fcmToken ?? "", category: .networking)
    }
}
