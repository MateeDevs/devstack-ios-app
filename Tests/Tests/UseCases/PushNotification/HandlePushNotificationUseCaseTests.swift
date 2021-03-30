//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class HandlePushNotificationUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let pushNotificationsRepository = PushNotificationsRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        setupPushNotificationsRepository()
        
        return RepositoryDependencyMock(
            pushNotificationsRepository: pushNotificationsRepository
        )
    }
    
    private func setupPushNotificationsRepository() {
        // We should test against concrete value instead of any, but I don't know how to mock [AnyHashable:Any]
        Given(pushNotificationsRepository, .decode(.any, willReturn: NETPushNotification.stubDomain))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = HandlePushNotificationUseCaseImpl(dependencies: setupDependencies())
        
        let output = useCase.execute([:])
        
        XCTAssertEqual(output, NETPushNotification.stubDomain)
        Verify(pushNotificationsRepository, 1, .decode(.any))
    }
}
