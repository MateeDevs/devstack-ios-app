//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class UpdateProfileCounterUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let updatedUser = User(copy: NETUser.stubDomain, counter: NETUser.stubDomain.counter + 1)
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    private let userRepository = UserRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        Given(authTokenRepository, .read(willReturn: NETAuthToken.stubDomain))
        Given(userRepository, .read(.value(.local), id: .value(NETUser.stubDomain.id), willReturn: .just(NETUser.stubDomain)))
        Given(userRepository, .update(.value(.local), user: .value(updatedUser), willReturn: .just(updatedUser)))
        
        return RepositoryDependencyMock(
            authTokenRepository: authTokenRepository,
            userRepository: userRepository
        )
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = UpdateProfileCounterUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(value: NETUser.stubDomain.counter + 1).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(authTokenRepository, 1, .read())
        Verify(userRepository, 1, .read(.value(.local), id: .value(NETUser.stubDomain.id)))
        Verify(userRepository, 1, .update(.value(.local), user: .value(updatedUser)))
    }
}
