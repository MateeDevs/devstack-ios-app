//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Firebase
import UIKit
import UserNotifications

public protocol HasPushNotificationsProvider {
    var pushNotificationsProvider: PushNotificationsProviderType { get }
}

public protocol PushNotificationsProviderType {
}

public class PushNotificationsProvider: NSObject, PushNotificationsProviderType {
    
    public init(application: UIApplication, appDelegate: (UIApplicationDelegate & UNUserNotificationCenterDelegate)) {
        super.init()
        
        // Start Firebase
        FirebaseApp.configure()
        
        // Setup APNs
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        UNUserNotificationCenter.current().delegate = appDelegate
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()
    }
}

extension PushNotificationsProvider: MessagingDelegate {
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Logger.debug("PushNotificationsProvider: FirebaseMessaging registration token:\n%@", fcmToken ?? "", category: .networking)
    }
}
