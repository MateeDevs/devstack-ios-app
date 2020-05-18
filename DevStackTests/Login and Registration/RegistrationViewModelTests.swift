//
//  RegistrationViewModelTests.swift
//  DevStackTests
//
//  Created by Matee on 13/03/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxTest
import RxSwift
@testable import A_DevStack
import XCTest

class RegistrationViewModelTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var viewModel: RegistrationViewModel!
    private var dependencies: AppDependency!
    private var disposeBag: DisposeBag!
    private var testScheduler: TestScheduler!
    
    // MARK: - Public Methods
    
    override func setUp() {
        super.setUp()
        dependencies = AppDependency()
        viewModel = RegistrationViewModel(dependencies: dependencies)
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        dependencies = nil
        testScheduler = nil
    }
    
    func testRegistration() {
        let registration = testScheduler.createObserver(Lce<User>.self)
       // let expectedEvent = dependencies.loginService.registration(email: "tomas.brand@matee.cz", password: "22222222", firstName: "Tomas", lastName: "Brand")
        
        viewModel.output.registration
            .drive()
            .disposed(by: disposeBag)
    
        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.registerButtonTaps)
            .disposed(by: disposeBag)
        
        testScheduler.start()
        
       // XCTAssertEqual(registration.events, [])
    }
}
