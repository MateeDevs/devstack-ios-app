//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class GetUsersUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        Given(userRepository, .list(.value(.local), page: .any, sortBy: .any, willReturn: .just(NETUser.stubListDomain)))
        
        return RepositoryDependencyMock(
            userRepository: userRepository
        )
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetUsersUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver([User].self)
        
        useCase.execute().bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubListDomain),
            .completed(0)
        ])
        Verify(userRepository, 1, .list(.value(.local), page: 0, sortBy: "id"))
    }
}
