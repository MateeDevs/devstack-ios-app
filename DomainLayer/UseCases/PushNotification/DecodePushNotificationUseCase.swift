//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol HasDecodePushNotificationUseCase {
    var decodePushNotificationUseCase: DecodePushNotificationUseCase { get }
}

public struct DecodePushNotificationUseCase {
    
    public typealias Dependencies = HasPushNotificationsRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(_ notificationData: [AnyHashable: Any]) -> PushNotification? {
        dependencies.pushNotificationsRepository.decode(notificationData)
    }
}
