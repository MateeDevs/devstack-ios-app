//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift
import SwiftyMocky
import XCTest

@testable import DataLayer

class LoginUseCaseTests: BaseTestCase {

    func testExecute() {
        let useCase = LoginUseCase(dependencies: RepositoryDependencyMock(
            authTokenRepository: AuthTokenRepositoryMock(createReturnValue: .just(NETAuthToken.stubDomain))
        ))

        let output = scheduler.createObserver(Bool.self)
        useCase.execute(LoginData(email: "email", pass: "pass"))
            .map { _ in true }.asDriver().drive(output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
    }
}
