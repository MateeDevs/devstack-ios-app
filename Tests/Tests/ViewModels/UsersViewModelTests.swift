////
////  Created by Petr Chmelar on 19.03.2021
////  Copyright © 2021 Matee. All rights reserved.
////
//
// import RxSwift
// import SwiftyMocky
// import XCTest
//
// @testable import DataLayer
// @testable import PresentationLayer
//
// class UsersViewModelTests: BaseTestCase {
//
//    // MARK: Dependencies
//
//    private let getUsersUseCase = GetUsersUseCaseMock()
//    private let refreshUsersUseCase = RefreshUsersUseCase()
//
//    private func setupDependencies() -> UseCaseDependencyMock {
//        setupGetUsersUseCase()
//        setupRefreshUsersUseCase()
//
//        return UseCaseDependencyMock(
//            getUsersUseCase: getUsersUseCase,
//            refreshUsersUseCase: refreshUsersUseCase
//        )
//    }
//
//    private func setupGetUsersUseCase() {
//        Given(getUsersUseCase, .execute(.any, willReturn: scheduler.createColdObservable([
//            .next(0, NETUser.stubListDomain),
//            .next(10, NETUser.stubListDomain)
//        ])))
//    }
//
//    private func setupRefreshUsersUseCase() {
//        Given(refreshUsersUseCase, .execute(.any, willReturn: .just(Constants.paginationCount)))
//    }
//
//    // MARK: Inputs and outputs
//
//    private struct Input {
//        var page = 0
//    }
//
//    private struct Output {
//        let users: TestableObserver<[User]>
//        let loadedCount: TestableObserver<Int>
//        let isRefreshing: TestableObserver<Bool>
//    }
//
//    private func generateOutput(for input: Input) -> Output {
//        let viewModel = UsersViewModel(dependencies: setupDependencies())
//
//        scheduler.createColdObservable([.next(0, input.page)])
//            .bind(to: viewModel.input.page).disposed(by: disposeBag)
//
//        return Output(
//            users: testableOutput(from: viewModel.output.users),
//            loadedCount: testableOutput(from: viewModel.output.loadedCount),
//            isRefreshing: testableOutput(from: viewModel.output.isRefreshing)
//        )
//    }
//
//    // MARK: Tests
//
//    func testPage() {
//        let output = generateOutput(for: Input(page: 0))
//
//        scheduler.start()
//
//        XCTAssertEqual(output.users.events, [
//
//        ])
//
//    }
//
//    func testLoginEmpty() {
//        let output = generateOutput(for: .loginEmpty)
//
//        scheduler.start()
//
//        XCTAssertEqual(output.flow.events, [])
//        XCTAssertEqual(output.alertAction.events, [
//            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials)))
//        ])
//        XCTAssertEqual(output.loginButtonEnabled.events, [
//            .next(0, true)
//        ])
//        Verify(loginUseCase, 0, .execute(.any))
//    }
//
//    func testLoginValid() {
//        let output = generateOutput(for: .loginValid)
//
//        scheduler.start()
//
//        XCTAssertEqual(output.flow.events, [
//            .next(0, .dismiss)
//        ])
//        XCTAssertEqual(output.alertAction.events, [
//            .next(0, .showWhisper(Whisper(L10n.signing_in))),
//            .next(0, .hideWhisper)
//        ])
//        XCTAssertEqual(output.loginButtonEnabled.events, [
//            .next(0, true),
//            .next(0, false),
//            .next(0, true)
//        ])
//        Verify(loginUseCase, 1, .execute(.value(.valid)))
//    }
//
//    func testLoginInvalidPassword() {
//        let output = generateOutput(for: .loginInvalidPassword)
//
//        scheduler.start()
//
//        XCTAssertEqual(output.flow.events, [])
//        XCTAssertEqual(output.alertAction.events, [
//            .next(0, .showWhisper(Whisper(L10n.signing_in))),
//            .next(0, .showWhisper(Whisper(error: L10n.invalid_credentials)))
//        ])
//        XCTAssertEqual(output.loginButtonEnabled.events, [
//            .next(0, true),
//            .next(0, false),
//            .next(0, true)
//        ])
//        Verify(loginUseCase, 1, .execute(.value(.invalidPassword)))
//    }
//
//    func testRegister() {
//        let output = generateOutput(for: .register)
//
//        scheduler.start()
//
//        XCTAssertEqual(output.flow.events, [
//            .next(0, .showRegistration)
//        ])
//        XCTAssertEqual(output.alertAction.events, [])
//        XCTAssertEqual(output.loginButtonEnabled.events, [
//            .next(0, true)
//        ])
//        Verify(loginUseCase, 0, .execute(.any))
//    }
// }
