//
//  LoginViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import RxSwift
import RxCocoa

final class LoginViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasLoginService
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
    }
    
    struct Input {
        let email: Driver<String>
        let password: Driver<String>
        let loginButtonTaps: Signal<()>
    }
    
    struct Output {
        let values: Driver<String>
        let loginEvent: Driver<Lce<Void>>
        let loginButtonEnabled: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let values = Driver.combineLatest(input.email, input.password) { "Email: \($0); Password: \($1)" }
        
        let activity = ActivityIndicator()
        let inputs = Driver.combineLatest(input.email, input.password) { (email: $0, password: $1) }
        
        let loginEvent = input.loginButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Driver<Lce<Void>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
                return Driver.just(Lce(error: ServiceError(statusCode: StatusCode.validationError, message: L10n.invalidCredentials)))
            } else {
                return self.dependencies.loginService.login(email: inputs.email, password: inputs.password)
                    .trackActivity(activity)
                    .startWith(Lce(loading: true))
                    .asDriverOnErrorJustComplete()
            }
        }
        
        let loginButtonEnabled = activity.asDriver().map({ (activity) -> Bool in
            return !activity
        })
        
        return Output(values: values, loginEvent: loginEvent, loginButtonEnabled: loginButtonEnabled)
    }
}
