//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class LoginUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependencyMock {
        setupAuthTokenRepository()
        
        return RepositoryDependencyMock(
            authTokenRepository: authTokenRepository
        )
    }
    
    private func setupAuthTokenRepository() {
        Given(authTokenRepository, .create(.any, willReturn: .just(NETAuthToken.stubDomain)))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = LoginUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(.valid).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(authTokenRepository, 1, .create(.value(.valid)))
    }
}
