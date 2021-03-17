//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct HandlePushNotificationUseCaseMock: HandlePushNotificationUseCaseType {
    var returnValue: PushNotification?
    
    func execute(_ notificationData: [AnyHashable: Any]) -> PushNotification? {
        return returnValue
    }
}
