//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

// import Foundation
//
// public protocol HasHandlePushNotificationUseCase {
//    var handlePushNotificationUseCase: HandlePushNotificationUseCase { get }
// }
//
// public struct HandlePushNotificationUseCase {
//
//    public typealias Dependencies = HasNoRepository
//
//    private let dependencies: Dependencies
//
//    public init(dependencies: Dependencies) {
//        self.dependencies = dependencies
//    }
//
//    func execute(_ notificationData: [AnyHashable: Any]) -> PushNotification? {
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: notificationData, options: [])
//            let notification = try JSONDecoder().decode(NETPushNotification.self, from: jsonData)
//            Logger.info("HandlePushNotificationUseCase: Notification received:\n%@", "\(notification)", category: .networking)
//            return notification.domainModel
//        } catch let error {
//            Logger.error("HandlePushNotificationUseCase: Error during notification decoding:\n%@", "\(error)", category: .networking)
//            return nil
//        }
//    }
// }
