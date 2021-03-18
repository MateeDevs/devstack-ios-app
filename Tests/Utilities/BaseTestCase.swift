//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import XCTest

// Global variable to easily check the order of events across all providers
var providerEvents: [ProviderEvent] = []

class BaseTestCase: XCTestCase {

    var scheduler: TestScheduler! // swiftlint:disable:this implicitly_unwrapped_optional
    var disposeBag: DisposeBag! // swiftlint:disable:this implicitly_unwrapped_optional

    override func setUp() {
        super.setUp()

        providerEvents = []
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        setupDependencies()
    }
    
    /// Override this method in a subclass and setup all required dependencies
    func setupDependencies() {}

    func testableOutput<T>(from driver: Driver<T>) -> TestableObserver<T> {
        let output = scheduler.createObserver(T.self)
        driver.drive(output).disposed(by: disposeBag)
        return output
    }
}
