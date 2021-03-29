//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class RegistrationUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependencyMock {
        setupUserRepository()
        
        return RepositoryDependencyMock(
            userRepository: userRepository
        )
    }
    
    private func setupUserRepository() {
        Given(userRepository, .create(.any, willReturn: .just(NETUser.stubDomain)))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = RegistrationUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(.valid).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(userRepository, 1, .create(.value(.valid)))
    }
}
