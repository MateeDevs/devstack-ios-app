//
//  LoginViewModelTests.swift
//  DevStackTests
//
//  Created by Matee on 01/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxTest
import RxSwift
@testable import A_DevStack
import XCTest

class LoginViewModelTests: XCTestCase {

    // MARK: - Private Properties
    
    private var viewModel: LoginViewModel!
    private var dependencies: AppDependency!
    private var disposeBag: DisposeBag!
    private var testScheduler: TestScheduler!
    
    // MARK: - Public Methods
    
    override func setUp() {
        super.setUp()
        dependencies = AppDependency()
        viewModel = LoginViewModel(dependencies: dependencies)
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        dependencies = nil
        testScheduler = nil
    }
    
    func testLogin() {
    /*    let email = testScheduler.createHotObservable([Recorded.next(220, "petr.chmelar@matee.cz"), Recorded.completed(20)])
        let password = testScheduler.createHotObservable([Recorded.next(230, "11111111"), Recorded.completed(20)])
        let buttonTaps = testScheduler.createHotObservable([Recorded.next(240, ()), Recorded.completed(20)])
        
        let recordObserver = testScheduler.start(disposed: 300) { () -> Observable<Lce<Void>> in
            let input = LoginViewModel.Input(email: email.asDriver(onErrorJustReturn: ""), password: password.asDriver(onErrorJustReturn: ""), loginButtonTaps: buttonTaps.asSignal(onErrorJustReturn: ()))
            let output = self.viewModel.transform(input: input)
            
            return output.loginEvent.asObservable()
        }
        
        let expectedEvents: [Recorded<Event<Lce<Void>>>] = [
            Recorded.next(240, Lce(loading: true))
        ]
        
        XCTAssert(recordObserver.events == expectedEvents)   */
        
        let login = testScheduler.createObserver(Lce<Void>.self)
       // let expectedEvent = dependencies.loginService.login(email: "petr.chmelar@matee.cz", password: "11111111")
        
        viewModel.output.login
            .drive()
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(10, ()), .next(30, ())])
            .bind(to: viewModel.input.loginButtonTaps)
            .disposed(by: disposeBag)
        
        testScheduler.start()
        
       // XCTAssertEqual(login.events, [])
    }
}
