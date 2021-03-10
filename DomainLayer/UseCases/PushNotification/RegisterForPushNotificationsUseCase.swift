//
//  Created by Petr Chmelar on 09.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import UserNotifications

public protocol HasRegisterForPushNotificationsUseCase {
    var registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCase { get }
}

public struct RegisterForPushNotificationsUseCase {
    
    public typealias Dependencies = HasPushNotificationsRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public func execute(
        options: UNAuthorizationOptions = [.alert, .badge, .sound],
        completionHandler: @escaping (Bool, Error?) -> Void = { _, _ in }
    ) {
        dependencies.pushNotificationsRepository.register(
            options: options,
            completionHandler: completionHandler
        )
    }
}
