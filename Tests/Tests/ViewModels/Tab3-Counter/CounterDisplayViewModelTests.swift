//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DataLayer
import DependencyInjection
import DomainLayer
@testable import PresentationLayer
import RxSwift
import SwiftyMocky
import XCTest

class CounterDisplayViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let getProfileUseCase = GetProfileUseCaseMock()
    
    private func setupDependencies() -> UseCaseDependency {
        Given(getProfileUseCase, .execute(willReturn: .just(NETUser.stubDomain)))
        return UseCaseDependencyMock(getProfileUseCase: getProfileUseCase)
    }
    
    // MARK: Inputs and outputs
    
    private struct Input {
        static let initialLoad = Input()
    }
    
    private struct Output {
        let counterValue: TestableObserver<String>
    }
    
    private func generateOutput(for input: Input) -> Output {
        let viewModel = CounterDisplayViewModel(dependencies: setupDependencies())
        
        return Output(
            counterValue: testableOutput(from: viewModel.output.counterValue)
        )
    }
    
    // MARK: Tests
    
    func testInitialLoad() {
        let output = generateOutput(for: .initialLoad)
        
        scheduler.start()
        
        XCTAssertEqual(output.counterValue.events, [
            .next(0, "\(NETUser.stubDomain.counter)"),
            .completed(0)
        ])
        Verify(getProfileUseCase, 1, .execute())
    }
}
