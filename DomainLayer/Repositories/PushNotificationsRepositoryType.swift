//
//  Created by Petr Chmelar on 09.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import UserNotifications

public protocol HasPushNotificationsRepository {
    var pushNotificationsRepository: PushNotificationsRepositoryType { get }
}

public protocol PushNotificationsRepositoryType: AutoMockable {
    func decode(_ notificationData: [AnyHashable: Any]) -> PushNotification?
    func register(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
}
