//
//  Created by Petr Chmelar on 20/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

@testable import DataLayer
import DependencyInjection
import DomainLayer
@testable import PresentationLayer
import RxSwift
import SwiftyMocky
import XCTest

class LoginViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let loginUseCase = LoginUseCaseMock()
    
    private func setupDependencies() -> UseCaseDependency {
        setupLoginUseCase()
        return UseCaseDependencyMock(loginUseCase: loginUseCase)
    }
    
    private func setupLoginUseCase() {
        Given(loginUseCase, .execute(
            .value(.invalidPassword),
            willReturn: .error(RepositoryError(statusCode: StatusCode.httpUnathorized, message: ""))
        ))
        Given(loginUseCase, .execute(.any, willReturn: .just(())))
    }

    // MARK: Inputs and outputs

    private struct Input {
        var loginData: [(time: TestTime, element: LoginData)] = []
        var loginButtonTaps: [(time: TestTime, element: Void)] = []
        var registerButtonTaps: [(time: TestTime, element: Void)] = []

        static let loginEmpty = Input(loginButtonTaps: [(0, ())])
        static let loginValid = Input(loginData: [(0, .valid)], loginButtonTaps: [(0, ())])
        static let loginInvalidPassword = Input(loginData: [(0, .invalidPassword)], loginButtonTaps: [(0, ())])
        static let loginInvalidThenValid = Input(
            loginData: [(0, .invalidPassword), (10, .valid)],
            loginButtonTaps: [(0, ()), (10, ())]
        )
        static let register = Input(registerButtonTaps: [(0, ())])
    }
    
    private struct Output {
        let flow: TestableObserver<LoginViewControllerFlow>
        let alertAction: TestableObserver<AlertAction>
        let loginButtonEnabled: TestableObserver<Bool>
    }

    private func generateOutput(for input: Input) -> Output {
        let viewModel = LoginViewModel(dependencies: setupDependencies())
        
        scheduler.createColdObservable(input.loginData.map { .next($0.time, $0.element.email) })
            .bind(to: viewModel.input.email).disposed(by: disposeBag)

        scheduler.createColdObservable(input.loginData.map { .next($0.time, $0.element.password) })
            .bind(to: viewModel.input.password).disposed(by: disposeBag)

        scheduler.createColdObservable(input.loginButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.loginButtonTaps).disposed(by: disposeBag)

        scheduler.createColdObservable(input.registerButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.registerButtonTaps).disposed(by: disposeBag)
        
        return Output(
            flow: testableOutput(from: viewModel.output.flow),
            alertAction: testableOutput(from: viewModel.output.alertAction),
            loginButtonEnabled: testableOutput(from: viewModel.output.loginButtonEnabled)
        )
    }

    // MARK: Tests

    func testLoginEmpty() {
        let output = generateOutput(for: .loginEmpty)
        
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
        let output = generateOutput(for: .loginValid)
        
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
        Verify(loginUseCase, 1, .execute(.value(.valid)))
    }

    func testLoginInvalidPassword() {
        let output = generateOutput(for: .loginInvalidPassword)
        
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
        Verify(loginUseCase, 1, .execute(.value(.invalidPassword)))
    }
    
    func testLoginInvalidThenValid() {
        let output = generateOutput(for: .loginInvalidThenValid)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(L10n.signing_in))),
            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials))),
            .next(10, .showWhisper(Whisper(L10n.signing_in))),
            .next(10, .hideWhisper)
        ])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true),
            .next(0, false),
            .next(0, true),
            .next(10, false),
            .next(10, true)
        ])
        Verify(loginUseCase, 1, .execute(.value(.invalidPassword)))
        Verify(loginUseCase, 1, .execute(.value(.valid)))
    }

    func testRegister() {
        let output = generateOutput(for: .register)
        
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
