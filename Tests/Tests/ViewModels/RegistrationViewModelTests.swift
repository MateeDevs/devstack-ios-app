//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

 import RxSwift
 import SwiftyMocky
 import XCTest

 @testable import PresentationLayer

 class RegistrationViewModelTests: BaseTestCase {

    // MARK: Dependencies

    private let registrationUseCase = RegistrationUseCaseMock()

    private func setupDependencies() -> UseCaseDependencyMock {
        setupRegistrationUseCase()

        return UseCaseDependencyMock(
            registrationUseCase: registrationUseCase
        )
    }

    private func setupRegistrationUseCase() {
        Given(registrationUseCase, .execute(
            .value(.existingEmail),
            willReturn: .error(RepositoryError(statusCode: StatusCode.httpConflict, message: ""))
        ))
        Given(registrationUseCase, .execute(.any, willReturn: .just(())))
    }

    // MARK: Inputs and outputs

    private struct Input {
        var registrationData: RegistrationData = .empty
        var registerButtonTaps: [(time: TestTime, element: Void)] = []
        var loginButtonTaps: [(time: TestTime, element: Void)] = []

        static let registerEmpty = Input(registerButtonTaps: [(0, ())])
        static let registerValid = Input(registrationData: .valid, registerButtonTaps: [(0, ())])
        static let registerInvalidEmail = Input(registrationData: .invalidEmail, registerButtonTaps: [(0, ())])
        static let registerExistingEmail = Input(registrationData: .existingEmail, registerButtonTaps: [(0, ())])
        static let login = Input(loginButtonTaps: [(0, ())])
    }

    private struct Output {
        let flow: TestableObserver<RegistrationViewControllerFlow>
        let alertAction: TestableObserver<AlertAction>
        let registerButtonEnabled: TestableObserver<Bool>
    }

    private func generateOutput(for input: Input) -> Output {
        let viewModel = RegistrationViewModel(dependencies: setupDependencies())

        scheduler.createColdObservable([.next(0, input.registrationData.email)])
            .bind(to: viewModel.input.email).disposed(by: disposeBag)

        scheduler.createColdObservable([.next(0, input.registrationData.password)])
            .bind(to: viewModel.input.password).disposed(by: disposeBag)

        scheduler.createColdObservable(input.registerButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.registerButtonTaps).disposed(by: disposeBag)

        scheduler.createColdObservable(input.loginButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.loginButtonTaps).disposed(by: disposeBag)

        return Output(
            flow: testableOutput(from: viewModel.output.flow),
            alertAction: testableOutput(from: viewModel.output.alertAction),
            registerButtonEnabled: testableOutput(from: viewModel.output.registerButtonEnabled)
        )
    }

    // MARK: Tests

    func testRegisterEmpty() {
        let output = generateOutput(for: .registerEmpty)

        scheduler.start()

        XCTAssertEqual(output.flow.events, [])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials)))
        ])
        XCTAssertEqual(output.registerButtonEnabled.events, [
            .next(0, true)
        ])
        Verify(registrationUseCase, 0, .execute(.any))
    }

    func testRegisterValid() {
        let output = generateOutput(for: .registerValid)

        scheduler.start()

        XCTAssertEqual(output.flow.events, [
            .next(0, .popRegistration)
        ])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(L10n.signing_up))),
            .next(0, .hideWhisper)
        ])
        XCTAssertEqual(output.registerButtonEnabled.events, [
            .next(0, true),
            .next(0, false),
            .next(0, true)
        ])
        Verify(registrationUseCase, 1, .execute(.value(.valid)))
    }

    func testRegisterInvalidEmail() {
        let output = generateOutput(for: .registerInvalidEmail)

        scheduler.start()

        XCTAssertEqual(output.flow.events, [])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(error: L10n.invalid_email)))
        ])
        XCTAssertEqual(output.registerButtonEnabled.events, [
            .next(0, true)
        ])
        Verify(registrationUseCase, 0, .execute(.value(.invalidEmail)))
    }
    
    func testRegisterExistingEmail() {
        let output = generateOutput(for: .registerExistingEmail)

        scheduler.start()

        XCTAssertEqual(output.flow.events, [])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(Whisper(L10n.signing_up))),
            .next(0, .showWhisper(Whisper(error: L10n.register_view_email_already_exists)))
        ])
        XCTAssertEqual(output.registerButtonEnabled.events, [
            .next(0, true),
            .next(0, false),
            .next(0, true)
        ])
        Verify(registrationUseCase, 1, .execute(.value(.existingEmail)))
    }

    func testLogin() {
        let output = generateOutput(for: .login)

        scheduler.start()

        XCTAssertEqual(output.flow.events, [
            .next(0, .popRegistration)
        ])
        XCTAssertEqual(output.alertAction.events, [])
        XCTAssertEqual(output.registerButtonEnabled.events, [
            .next(0, true)
        ])
        Verify(registrationUseCase, 0, .execute(.any))
    }
 }
