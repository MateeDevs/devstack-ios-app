//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class AuthTokenRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let databaseProvider = DatabaseProviderMock()
    private let keychainProvider = KeychainProviderMock()
    private let networkProvider = NetworkProviderMock()
    
    private func setupDependencies() -> ProviderDependencyMock {
        setupKeychainProvider()
        
        return ProviderDependencyMock(
            databaseProvider: databaseProvider,
            keychainProvider: keychainProvider,
            networkProvider: networkProvider
        )
    }
    
    private func setupKeychainProvider() {
        Given(keychainProvider, .get(.value(.authToken), willReturn: NETAuthToken.stubDomain.token))
        Given(keychainProvider, .get(.value(.userId), willReturn: NETAuthToken.stubDomain.userId))
    }
    
    // MARK: Tests
    
    func testCreateValid() {
        let repository = AuthTokenRepositoryImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(AuthToken.self)
        
        repository.create(.valid).asDriver().drive(output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETAuthToken.stubDomain),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        Verify(keychainProvider, 1, .save(.value(.authToken), value: .value(NETAuthToken.stubDomain.token)))
        Verify(keychainProvider, 1, .save(.value(.userId), value: .value(NETAuthToken.stubDomain.userId)))
    }
    
    func testRead() {
        let repository = AuthTokenRepositoryImpl(dependencies: setupDependencies())
        
        let output = repository.read()
        
        XCTAssertEqual(output, NETAuthToken.stubDomain)
        Verify(keychainProvider, 1, .get(.value(.userId)))
        Verify(keychainProvider, 1, .get(.value(.authToken)))
    }
    
    func testDelete() {
        let repository = AuthTokenRepositoryImpl(dependencies: setupDependencies())
        
        repository.delete()
        
        XCTAssertEqual(databaseProvider.deleteAllCallsCount, 1)
        Verify(keychainProvider, 1, .deleteAll())
    }
}
