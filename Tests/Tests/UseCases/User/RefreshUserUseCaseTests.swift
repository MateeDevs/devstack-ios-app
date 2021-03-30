//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class RefreshUserUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        setupUserRepository()
        
        return RepositoryDependencyMock(
            userRepository: userRepository
        )
    }
    
    private func setupUserRepository() {
        Given(userRepository, .read(.value(.remote), id: .value(NETUser.stubDomain.id), willReturn: .just(NETUser.stubDomain)))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = RefreshUserUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(id: NETUser.stubDomain.id).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(userRepository, 1, .read(.value(.remote), id: .value(NETUser.stubDomain.id)))
    }
}
