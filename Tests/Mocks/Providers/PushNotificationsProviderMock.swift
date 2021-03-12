//
//  Created by Petr Chmelar on 23.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import UserNotifications

class PushNotificationsProviderMock: PushNotificationsProviderType {
    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        providerEvents.append(.pushNotificationsRequestAuthorization)
    }
}
