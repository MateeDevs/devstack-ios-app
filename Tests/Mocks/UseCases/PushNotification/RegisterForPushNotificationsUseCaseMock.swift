//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import UserNotifications

struct RegisterForPushNotificationsUseCaseMock: RegisterForPushNotificationsUseCaseType {
    func execute(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {}
}
