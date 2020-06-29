//
//  LoginViewModelTests.swift
//  DevStack
//
//  Created by Petr Chmelar on 20/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import RxTest
import XCTest

@testable import A_DevStack

class LoginViewModelTests: BaseTestCase {

    // MARK: Mock

    private struct Input {
        let email: String
        let password: String
        let tap: Void
    }

    private struct Inputs {
        static let empty = Input(email: "", password: "", tap: ())
        static let nonEmpty = Input(email: "email", password: "pass", tap: ())
    }
    
    private struct Output {
        let loginSuccess: TestableObserver<Bool>
        let alertAction: TestableObserver<AlertAction>
        let loginButtonEnabled: TestableObserver<Bool>
    }

    private func mockViewModel(for input: Input, providers: ProviderDependency = .mock()) -> Output {
        let viewModel = LoginViewModel(dependencies: ServiceDependency(dependencies: providers))
        
        scheduler.createColdObservable([.next(0, input.email)])
            .bind(to: viewModel.input.email).disposed(by: disposeBag)

        scheduler.createColdObservable([.next(0, input.password)])
            .bind(to: viewModel.input.password).disposed(by: disposeBag)

        scheduler.createColdObservable([.next(0, ())])
            .bind(to: viewModel.input.loginButtonTaps).disposed(by: disposeBag)
        
        return Output(
            loginSuccess: testableOutput(from: viewModel.output.loginSuccess.map { true }),
            alertAction: testableOutput(from: viewModel.output.alertAction),
            loginButtonEnabled: testableOutput(from: viewModel.output.loginButtonEnabled)
        )
    }

    // MARK: Tests for Output.loginSuccess
    
    func testLoginSuccessOutputForNonEmptyInput() {
        let output = mockViewModel(for: Inputs.nonEmpty)
        scheduler.start()
        XCTAssertEqual(output.loginSuccess.events, [
            .next(0, true)
        ])
    }

    func testLoginSuccessOutputForEmptyInput() {
        let output = mockViewModel(for: Inputs.empty)
        scheduler.start()
        XCTAssertEqual(output.loginSuccess.events, [])
    }

    func testLoginSuccessOutputForWrongPassword() {
        let providers: ProviderDependency = .mock(networkResponse: .unauthorized)
        let output = mockViewModel(for: Inputs.nonEmpty, providers: providers)
        scheduler.start()
        XCTAssertEqual(output.loginSuccess.events, [])
    }

    // MARK: Tests for Output.whisperAction
    
    func testWhisperActionOutputForNonEmptyInput() {
        let output = mockViewModel(for: Inputs.nonEmpty)
        scheduler.start()
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(L10n.signing_in))),
            .next(0, .hideWhisper)
        ])
    }

    func testWhisperActionOutputForEmptyInput() {
        let output = mockViewModel(for: Inputs.empty)
        scheduler.start()
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials)))
        ])
    }

    func testWhisperActionOutputForWrongPassword() {
        let providers: ProviderDependency = .mock(networkResponse: .unauthorized)
        let output = mockViewModel(for: Inputs.nonEmpty, providers: providers)
        scheduler.start()
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(L10n.signing_in))),
            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials)))
        ])
    }

    // MARK: Tests for Output.loginButtonEnabled

    func testLoginButtonEnabledOutput() {
        let output = mockViewModel(for: Inputs.nonEmpty)
        scheduler.start()
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true),
            .next(0, false),
            .next(0, true)
        ])
    }

    // MARK: Test for requestDidCalled

    func testRequestDidFire() {
        let networkProvider = NetworkProviderMock()
        let providers: ProviderDependency = .mock(networkProvider: networkProvider)
        
        _ = mockViewModel(for: Inputs.nonEmpty, providers: providers)
        scheduler.start()
        
        XCTAssertEqual(networkProvider.firedRequests, 1)
    }

}
