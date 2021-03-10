//
//  Created by Petr Chmelar on 20/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import XCTest

@testable import PresentationLayer

class LoginViewModelTests: BaseTestCase {

    // MARK: Mock

    private struct Input {
        var email: String = ""
        var password: String = ""
        var loginButtonTaps: [Void] = []
        var registerButtonTaps: [Void] = []

        static let loginEmpty = Input(loginButtonTaps: [()])
        static let loginNonEmpty = Input(email: "email", password: "pass", loginButtonTaps: [()])
        static let register = Input(registerButtonTaps: [()])
    }
    
    private struct Output {
        let flow: TestableObserver<LoginViewControllerFlow>
        let alertAction: TestableObserver<AlertAction>
        let loginButtonEnabled: TestableObserver<Bool>
    }

    @discardableResult private func mockViewModel(for input: Input, providers: ProviderDependency = .mock()) -> Output {
        let viewModel = LoginViewModel(dependencies: UseCaseDependency(dependencies: RepositoryDependency(dependencies: providers)))
        
        scheduler.createColdObservable([.next(0, input.email)])
            .bind(to: viewModel.input.email).disposed(by: disposeBag)

        scheduler.createColdObservable([.next(0, input.password)])
            .bind(to: viewModel.input.password).disposed(by: disposeBag)

        scheduler.createColdObservable(input.loginButtonTaps.map { .next(0, $0) })
            .bind(to: viewModel.input.loginButtonTaps).disposed(by: disposeBag)

        scheduler.createColdObservable(input.registerButtonTaps.map { .next(0, $0) })
            .bind(to: viewModel.input.registerButtonTaps).disposed(by: disposeBag)
        
        return Output(
            flow: testableOutput(from: viewModel.output.flow),
            alertAction: testableOutput(from: viewModel.output.alertAction),
            loginButtonEnabled: testableOutput(from: viewModel.output.loginButtonEnabled)
        )
    }

    // MARK: Tests for Output.flow

    func testFlowOutputForLoginEmpty() {
        let output = mockViewModel(for: Input.loginEmpty)
        scheduler.start()
        XCTAssertEqual(output.flow.events, [])
    }

    func testFlowOutputForLoginCorrectPassword() {
        let output = mockViewModel(for: Input.loginNonEmpty)
        scheduler.start()
        XCTAssertEqual(output.flow.events, [
            .next(0, .dismiss)
        ])
    }

    func testFlowOutputForLoginWrongPassword() {
        let providers: ProviderDependency = .mock(networkResponse: .unauthorized)
        let output = mockViewModel(for: Input.loginNonEmpty, providers: providers)
        scheduler.start()
        XCTAssertEqual(output.flow.events, [])
    }

    func testFlowOutputForRegister() {
        let output = mockViewModel(for: Input.register)
        scheduler.start()
        XCTAssertEqual(output.flow.events, [
            .next(0, .showRegistration)
        ])
    }

    // MARK: Tests for Output.alertAction

    func testWhisperActionOutputForLoginEmpty() {
        let output = mockViewModel(for: Input.loginEmpty)
        scheduler.start()
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials)))
        ])
    }
    
    func testAlertActionOutputForLoginCorrectPassword() {
        let output = mockViewModel(for: Input.loginNonEmpty)
        scheduler.start()
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(L10n.signing_in))),
            .next(0, .hideWhisper)
        ])
    }

    func testAlertActionOutputForLoginWrongPassword() {
        let providers: ProviderDependency = .mock(networkResponse: .unauthorized)
        let output = mockViewModel(for: Input.loginNonEmpty, providers: providers)
        scheduler.start()
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(L10n.signing_in))),
            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials)))
        ])
    }

    func testAlertActionOutputForRegister() {
        let output = mockViewModel(for: Input.register)
        scheduler.start()
        XCTAssertEqual(output.alertAction.events, [])
    }

    // MARK: Tests for Output.loginButtonEnabled

    func testLoginButtonEnabledOutput() {
        let output = mockViewModel(for: Input.loginNonEmpty)
        scheduler.start()
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true),
            .next(0, false),
            .next(0, true)
        ])
    }

    // MARK: Test for requestDidCalled

    func testLoginRequestDidFire() {
        let networkProvider = NetworkProviderMock()
        let providers: ProviderDependency = .mock(networkProvider: networkProvider)
        
        mockViewModel(for: Input.loginNonEmpty, providers: providers)
        scheduler.start()
        
        XCTAssertEqual(networkProvider.firedRequests, 1)
    }

}
