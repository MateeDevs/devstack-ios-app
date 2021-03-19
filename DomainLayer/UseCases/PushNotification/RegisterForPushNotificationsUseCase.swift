//
//  Created by Petr Chmelar on 09.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import UserNotifications

public protocol HasRegisterForPushNotificationsUseCase {
    var registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCaseType { get }
}

public protocol RegisterForPushNotificationsUseCaseType {
    func execute(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
}

public struct RegisterForPushNotificationsUseCase: RegisterForPushNotificationsUseCaseType {
    
    public typealias Dependencies = HasPushNotificationsRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public func execute(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        dependencies.pushNotificationsRepository.register(
            options: options,
            completionHandler: completionHandler
        )
    }
}
