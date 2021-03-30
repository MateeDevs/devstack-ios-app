//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class UpdateUserUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let updatedUser = User(copy: NETUser.stubDomain, bio: "Updated user")
    
    private let userRepository = UserRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        setupUserRepository()
        
        return RepositoryDependencyMock(
            userRepository: userRepository
        )
    }
    
    private func setupUserRepository() {
        Given(userRepository, .update(.value(.remote), user: .value(updatedUser), willReturn: .just(updatedUser)))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = UpdateUserUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(user: updatedUser).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(userRepository, 1, .update(.value(.remote), user: .value(updatedUser)))
    }
}
