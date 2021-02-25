//
//  AuthTokenRepositoryTests.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import XCTest

@testable import A_DevStack

class AuthTokenRepositoryTests: BaseTestCase {

    // MARK: Tests for login

    func testCreateRequestDidFire() {
        let networkProvider = NetworkProviderMock()
        let providers: ProviderDependency = .mock(networkProvider: networkProvider)
        let authRepository = AuthTokenRepository(dependencies: providers)

        let output = scheduler.createObserver(Bool.self)
        authRepository.create(LoginData(email: "email", pass: "pass"))
            .asDriver().map { _ in true }.drive(output).disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(networkProvider.firedRequests, 1)
    }

    func testCreateKeychainSavedKeys() {
        let keychainProvider = KeychainProviderMock()
        let providers: ProviderDependency = .mock(keychainProvider: keychainProvider)
        let authRepository = AuthTokenRepository(dependencies: providers)

        let output = scheduler.createObserver(Bool.self)
        authRepository.create(LoginData(email: "email", pass: "pass"))
            .asDriver().map { _ in true }.drive(output).disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(keychainProvider.savedKeys, [.authToken, .userId])
    }
}
