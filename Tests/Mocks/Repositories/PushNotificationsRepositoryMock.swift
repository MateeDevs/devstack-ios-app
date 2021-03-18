//
//  Created by Petr Chmelar on 18.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation
import UserNotifications

struct PushNotificationsRepositoryMock: PushNotificationsRepositoryType {
    
    var decodeReturnValue: PushNotification?
    
    func decode(_ notificationData: [AnyHashable: Any]) -> PushNotification? {
        return decodeReturnValue
    }
    
    func register(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {}
}
