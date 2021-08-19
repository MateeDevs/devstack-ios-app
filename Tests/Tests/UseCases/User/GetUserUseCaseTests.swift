//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DataLayer
import DependencyInjection
import DomainLayer
import RxSwift
import RxTest
import SwiftyMocky
import XCTest

class GetUserUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        Given(userRepository, .read(.value(.local), id: .value(NETUser.stubDomain.id), willReturn: .just(NETUser.stubDomain)))
        return RepositoryDependencyMock(userRepository: userRepository)
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetUserUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(User.self)
        
        useCase.execute(id: NETUser.stubDomain.id).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETUser.stubDomain),
            .completed(0)
        ])
        Verify(userRepository, 1, .read(.value(.local), id: .value(NETUser.stubDomain.id)))
    }
}
