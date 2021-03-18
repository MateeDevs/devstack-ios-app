//
//  Created by Petr Chmelar on 20/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import PresentationLayer

class LoginViewModelTests: BaseTestCase {

    // MARK: Setup inputs and outputs

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
    
    // MARK: Mock

    private func mockViewModel(for input: Input) -> Output {
        let loginUseCaseMock = LoginUseCaseTypeMock()
        Given(loginUseCaseMock, .execute(
                .value(LoginData(email: "email", pass: "invalidPass")),
                willReturn: .error(RepositoryError(statusCode: StatusCode.httpUnathorized, message: "")))
        )
        Given(loginUseCaseMock, .execute(.any, willReturn: .just(())))
        
        let viewModel = LoginViewModel(dependencies: UseCaseDependencyMock(loginUseCase: loginUseCaseMock))
        
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
        let output = mockViewModel(for: Input.loginEmpty)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials)))
        ])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true)
        ])
    }

    func testLoginValid() {
        let output = mockViewModel(for: Input.loginValid)
        
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
    }

    func testLoginInvalid() {
        let output = mockViewModel(for: Input.loginInvalid)
        
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
    }

    func testRegister() {
        let output = mockViewModel(for: Input.register)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [
            .next(0, .showRegistration)
        ])
        XCTAssertEqual(output.alertAction.events, [])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true)
        ])
    }
}
