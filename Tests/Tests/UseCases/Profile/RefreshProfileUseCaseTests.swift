//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class RefreshProfileUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    private let userRepository = UserRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        Given(authTokenRepository, .read(willReturn: NETAuthToken.stubDomain))
        Given(userRepository, .read(.value(.remote), id: .value(NETUser.stubDomain.id), willReturn: .just(NETUser.stubDomain)))
        
        return RepositoryDependencyMock(
            authTokenRepository: authTokenRepository,
            userRepository: userRepository
        )
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = RefreshProfileUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute().map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(authTokenRepository, 1, .read())
        Verify(userRepository, 1, .read(.value(.remote), id: .value(NETUser.stubDomain.id)))
    }
}
