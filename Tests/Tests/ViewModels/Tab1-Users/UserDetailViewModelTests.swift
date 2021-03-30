//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer
@testable import PresentationLayer

class UserDetailViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let dbStream = BehaviorSubject<User>(value: NETUser.stubDomain)
    
    private let getUserUseCase = GetUserUseCaseMock()
    private let refreshUserUseCase = RefreshUserUseCaseMock()
    
    private func setupDependencies() -> UseCaseDependency {
        setupGetUserUseCase()
        setupRefreshUserUseCase()
        
        return UseCaseDependencyMock(
            getUserUseCase: getUserUseCase,
            refreshUserUseCase: refreshUserUseCase
        )
    }
    
    private func setupGetUserUseCase() {
        Given(getUserUseCase, .execute(id: .value(NETUser.stubDomain.id), willReturn: dbStream.asObservable()))
    }
    
    private func setupRefreshUserUseCase() {
        Given(refreshUserUseCase, .execute(id: .value(NETUser.stubDomain.id), willReturn: .just(())))
    }
    
    // MARK: Inputs and outputs
    
    private struct Input {
        var refreshTrigger: [(time: TestTime, element: Void)] = []
        
        static let initialLoad = Input(refreshTrigger: [(0, ())])
    }
    
    private struct Output {
        let user: OutputUser
        let isRefreshing: TestableObserver<Bool>
    }
    
    private struct OutputUser {
        let fullName: TestableObserver<String>
        let initials: TestableObserver<String>
        let imageURL: TestableObserver<String?>
    }
    
    private func generateOutput(for input: Input) -> Output {
        let viewModel = UserDetailViewModel(dependencies: setupDependencies(), userId: NETUser.stubDomain.id)
        
        scheduler.createColdObservable(input.refreshTrigger.map { .next($0.time, $0.element) })
            .do { [weak self] _ in self?.dbStream.onNext(NETUser.stubDomain) }
            .bind(to: viewModel.input.refreshTrigger).disposed(by: disposeBag)
        
        return Output(
            user: OutputUser(
                fullName: testableOutput(from: viewModel.output.user.fullName),
                initials: testableOutput(from: viewModel.output.user.initials),
                imageURL: testableOutput(from: viewModel.output.user.imageURL)
            ),
            isRefreshing: testableOutput(from: viewModel.output.isRefreshing)
        )
    }
    
    // MARK: Tests
    
    func testInitialLoad() {
        let output = generateOutput(for: .initialLoad)
        
        scheduler.start()
        
        XCTAssertEqual(output.user.fullName.events, [
            .next(0, NETUser.stubDomain.fullName),
            .next(0, NETUser.stubDomain.fullName)
        ])
        XCTAssertEqual(output.user.initials.events, [
            .next(0, NETUser.stubDomain.fullName.initials),
            .next(0, NETUser.stubDomain.fullName.initials)
        ])
        XCTAssertEqual(output.user.imageURL.events, [
            .next(0, NETUser.stubDomain.pictureUrl),
            .next(0, NETUser.stubDomain.pictureUrl)
        ])
        XCTAssertEqual(output.isRefreshing.events, [
            .next(0, false),
            .next(0, true),
            .next(0, false),
            .next(0, false)
        ])
        Verify(getUserUseCase, 1, .execute(id: .value(NETUser.stubDomain.id)))
        Verify(refreshUserUseCase, 1, .execute(id: .value(NETUser.stubDomain.id)))
    }
}
