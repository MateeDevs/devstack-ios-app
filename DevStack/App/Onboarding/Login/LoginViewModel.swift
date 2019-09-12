//
//  LoginViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
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
        let loginEvent: Driver<Lce<Void>>
        let loginButtonEnabled: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let activity = ActivityIndicator()
        let inputs = Driver.combineLatest(input.email, input.password) { (email: $0, password: $1) }
        
        let loginEvent = input.loginButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Driver<Lce<Void>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
				return Driver.just(Lce(error: ValidationError(L10n.invalid_credentials)))
            } else {
                return self.dependencies.loginService.login(email: inputs.email, password: inputs.password)
                    .trackActivity(activity)
                    .asDriverOnErrorJustComplete()
            }
        }
        
        let loginButtonEnabled = activity.asDriver().map({ (activity) -> Bool in
            return !activity
        })
        
        return Output(loginEvent: loginEvent, loginButtonEnabled: loginButtonEnabled)
    }
}
