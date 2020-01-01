//
//  LoginViewModelTests.swift
//  DevStackTests
//
//  Created by Matee on 01/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxTest
import RxSwift
@testable import DevStack
import XCTest

class LoginViewModelTests: XCTestCase {

    // MARK: - Private Properties
    
    private var viewModel: LoginViewModel!
    private var dependencies: LoginServiceMock!
    private var disposeBag: DisposeBag!
    private var testScheduler: TestScheduler!
    
    // MARK: - Public Methods
    
    override func setUp() {
        dependencies = LoginServiceMock()
        viewModel = LoginViewModel(dependencies: dependencies)
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        viewModel = nil
        dependencies = nil
        testScheduler = nil
        
        super.tearDown()
    }
    
    func testLogin() {
        let email = testScheduler.createHotObservable([next(220, "petr.chmelar@matee.cz"), completed(20)])
        let password = testScheduler.createHotObservable([next(230, "11111111"), completed(20)])
        let buttonTaps = testScheduler.createHotObservable([next(240, ()), completed(20)])
        
        let recordObserver = testScheduler.start(disposed: 300) { () -> Observable<Lce<Void>> in
            let input = LoginViewModel.Input(email: email.asDriver(onErrorJustReturn: ""), password: password.asDriver(onErrorJustReturn: ""), loginButtonTaps: buttonTaps.asSignal(onErrorJustReturn: ()))
            let output = self.viewModel.transform(input: input)
            
            return output.loginEvent.asObservable()
        }
        
        let expectedEvents: [Recorded<Event<Lce<Void>>>] = [
            next(240, Lce(loading: true))
        ]
        
        XCTAssert(recordObserver.events == expectedEvents)
    }
}
