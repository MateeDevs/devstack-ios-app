//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import UserNotifications

public protocol HasPushNotificationsProvider {
    var pushNotificationsProvider: PushNotificationsProviderType { get }
}

public protocol PushNotificationsProviderType {
    /// Request user's authorization for push notifications
    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
}
