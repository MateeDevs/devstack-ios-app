//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class GetProfileIdUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        Given(authTokenRepository, .read(willReturn: NETAuthToken.stubDomain))
        
        return RepositoryDependencyMock(
            authTokenRepository: authTokenRepository
        )
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetProfileIdUseCaseImpl(dependencies: setupDependencies())
        
        let output = useCase.execute()
        
        XCTAssertEqual(output, NETAuthToken.stubDomain.userId)
        Verify(authTokenRepository, 1, .read())
    }
}
