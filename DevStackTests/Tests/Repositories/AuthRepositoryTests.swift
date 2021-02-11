//
//  AuthRepositoryTests.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import RxTest
import XCTest

@testable import A_DevStack

class AuthRepositoryTests: BaseTestCase {

    // MARK: Tests for login

    func testLoginRequestDidFire() {
        let networkProvider = NetworkProviderMock()
        let providers: ProviderDependency = .mock(networkProvider: networkProvider)
        let loginRepository = LoginRepository(dependencies: providers)

        let output = scheduler.createObserver(Bool.self)
        loginRepository.login(email: "email", password: "pass")
            .asDriver().map { true }.drive(output).disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(networkProvider.firedRequests, 1)
    }

    func testLoginKeychainSavedKeys() {
        let keychainProvider = KeychainProviderMock()
        let providers: ProviderDependency = .mock(keychainProvider: keychainProvider)
        let loginRepository = LoginRepository(dependencies: providers)

        let output = scheduler.createObserver(Bool.self)
        loginRepository.login(email: "email", password: "pass")
            .asDriver().map { true }.drive(output).disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(keychainProvider.savedKeys, [.authToken, .userId])
    }
}
