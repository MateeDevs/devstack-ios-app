//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class UserRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let databaseProvider = DatabaseProviderMock()
    private let networkProvider = NetworkProviderMock()
    
    private func setupDependencies() -> ProviderDependencyMock {
        return ProviderDependencyMock(
            databaseProvider: databaseProvider,
            networkProvider: networkProvider
        )
    }
    
    // MARK: Tests
    
    //    func testCreate() {
    //        let repository = UserRepositoryImpl(dependencies: setupDependencies())
    //        let output = scheduler.createObserver(User.self)
    //
    //        repository.create(.valid).asDriver().drive(output).disposed(by: disposeBag)
    //        scheduler.start()
    //
    //        XCTAssertEqual(output.events, [
    //            .next(0, NETUser.stubDomain),
    //            .completed(0)
    //        ])
    //        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
    //        Verify(keychainProvider, 1, .save(.value(.authToken), value: .value(NETAuthToken.stubDomain.token)))
    //        Verify(keychainProvider, 1, .save(.value(.userId), value: .value(NETAuthToken.stubDomain.userId)))
    //    }
    //
    //    func testRead() {
    //        let repository = AuthTokenRepositoryImpl(dependencies: setupDependencies())
    //
    //        let output = repository.read()
    //
    //        XCTAssertEqual(output, NETAuthToken.stubDomain)
    //        Verify(keychainProvider, 1, .get(.value(.userId)))
    //        Verify(keychainProvider, 1, .get(.value(.authToken)))
    //    }
    //
    //    func testDelete() {
    //        let repository = AuthTokenRepositoryImpl(dependencies: setupDependencies())
    //
    //        repository.delete()
    //
    //        Verify(keychainProvider, 1, .deleteAll())
    //        XCTAssertEqual(databaseProvider.deleteAllCallsCount, 1)
    //    }
}
