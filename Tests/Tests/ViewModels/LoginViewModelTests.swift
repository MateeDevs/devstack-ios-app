//
//  Created by Petr Chmelar on 20/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import PresentationLayer

class LoginViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let loginUseCase = LoginUseCaseTypeMock()
    
    private func setupDependencies() -> UseCaseDependencyMock {
        setupLoginUseCase()
        
        return UseCaseDependencyMock(
            loginUseCase: loginUseCase
        )
    }
    
    private func setupLoginUseCase() {
        Given(loginUseCase, .execute(
            .value(LoginData(email: "email", pass: "invalidPass")),
            willReturn: .error(RepositoryError(statusCode: StatusCode.httpUnathorized, message: ""))
        ))
        Given(loginUseCase, .execute(.any, willReturn: .just(())))
    }

    // MARK: Inputs and outputs

    private struct Input {
        var email: String = ""
        var password: String = ""
        var loginButtonTaps: [Void] = []
        var registerButtonTaps: [Void] = []

        static let loginEmpty = Input(loginButtonTaps: [()])
        static let loginValid = Input(email: "email", password: "validPass", loginButtonTaps: [()])
        static let loginInvalid = Input(email: "email", password: "invalidPass", loginButtonTaps: [()])
        static let register = Input(registerButtonTaps: [()])
    }
    
    private struct Output {
        let flow: TestableObserver<LoginViewControllerFlow>
        let alertAction: TestableObserver<AlertAction>
        let loginButtonEnabled: TestableObserver<Bool>
    }

    private func generateOutput(for input: Input) -> Output {
        let viewModel = LoginViewModel(dependencies: setupDependencies())
        
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

    // MARK: Tests

    func testLoginEmpty() {
        let output = generateOutput(for: Input.loginEmpty)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials)))
        ])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true)
        ])
        Verify(loginUseCase, 0, .execute(.any))
    }

    func testLoginValid() {
        let output = generateOutput(for: Input.loginValid)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [
            .next(0, .dismiss)
        ])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(L10n.signing_in))),
            .next(0, .hideWhisper)
        ])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true),
            .next(0, false),
            .next(0, true)
        ])
        Verify(loginUseCase, 1, .execute(.value(LoginData(
            email: Input.loginValid.email,
            pass: Input.loginValid.password
        ))))
    }

    func testLoginInvalid() {
        let output = generateOutput(for: Input.loginInvalid)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(L10n.signing_in))),
            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials)))
        ])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true),
            .next(0, false),
            .next(0, true)
        ])
        Verify(loginUseCase, 1, .execute(.value(LoginData(
            email: Input.loginInvalid.email,
            pass: Input.loginInvalid.password
        ))))
    }

    func testRegister() {
        let output = generateOutput(for: Input.register)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [
            .next(0, .showRegistration)
        ])
        XCTAssertEqual(output.alertAction.events, [])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true)
        ])
        Verify(loginUseCase, 0, .execute(.any))
    }
}
