//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class GetUserUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependencyMock {
        setupUserRepository()
        
        return RepositoryDependencyMock(
            userRepository: userRepository
        )
    }
    
    private func setupUserRepository() {
        Given(userRepository, .read(.value(.local), id: .value(NETUser.stubDomain.id), willReturn: .just(NETUser.stubDomain)))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetUserUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(User.self)
        
        useCase.execute(id: NETUser.stubDomain.id).asDriver().drive(output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubDomain),
            .completed(0)
        ])
        Verify(userRepository, 1, .read(.value(.local), id: .value(NETUser.stubDomain.id)))
    }
}
