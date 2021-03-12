//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import XCTest

@testable import DataLayer

class AuthTokenRepositoryTests: BaseTestCase {

    func testCreate() {
        let repository = AuthTokenRepository(dependencies: ProviderDependency.mock())

        let output = scheduler.createObserver(AuthToken.self)
        repository.create(LoginData(email: "email", pass: "pass"))
            .asDriver().drive(output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, NETAuthToken.stubDomain),
            .completed(0)
        ])
        XCTAssertEqual(providerEvents, [
            .networkRequest,
            .keychainSave(.authToken),
            .keychainSave(.userId)
        ])
    }
    
    func testRead() {
        let keychainProvider = KeychainProviderMock([
            .authToken: NETAuthToken.stubDomain.token,
            .userId: NETAuthToken.stubDomain.userId
        ])
        let repository = AuthTokenRepository(dependencies: ProviderDependency.mock(keychainProvider: keychainProvider))

        let output = repository.read()
        
        XCTAssertEqual(output, NETAuthToken.stubDomain)
        XCTAssertEqual(providerEvents, [
            .keychainGet(.userId),
            .keychainGet(.authToken)
        ])
    }
    
    func testDelete() {
        let keychainProvider = KeychainProviderMock([
            .authToken: NETAuthToken.stubDomain.token,
            .userId: NETAuthToken.stubDomain.userId
        ])
        let repository = AuthTokenRepository(dependencies: ProviderDependency.mock(keychainProvider: keychainProvider))

        repository.delete()
        
        XCTAssertEqual(keychainProvider.storage, [:])
        XCTAssertEqual(providerEvents, [
            .keychainDeleteAll,
            .databaseDeleteAll
        ])
    }
}
