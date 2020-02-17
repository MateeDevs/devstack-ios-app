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
    
    let input: Input
    let output: Output
    
    struct Input {
        let email: AnyObserver<String>
        let password: AnyObserver<String>
        let loginButtonTaps: AnyObserver<Void>
    }
    
    struct Output {
        let loginEvent: Driver<Lce<Void>>
        let loginButtonEnabled: Driver<Bool>
    }
    
    init(dependencies: Dependencies) {
        let email = ReplaySubject<String>.create(bufferSize: 1)
        let password = ReplaySubject<String>.create(bufferSize: 1)
        let loginButtonTaps = PublishSubject<Void>()
        
        let activity = ActivityIndicator()
        let inputs = Observable.combineLatest(email, password) { (email: $0, password: $1) }
        
        let loginEvent = loginButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Observable<Lce<Void>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
                return Observable.just(Lce(error: ValidationError(L10n.invalid_credentials)))
            } else {
                return dependencies.loginService
                    .login(email: inputs.email, password: inputs.password)
                    .trackActivity(activity)
            }
        }.asDriverOnErrorJustComplete()
        
        let loginButtonEnabled = activity.asDriver().map({ (activity) -> Bool in
            !activity
        })
        
        self.input = Input(email: email.asObserver(), password: password.asObserver(), loginButtonTaps: loginButtonTaps.asObserver())
        self.output = Output(loginEvent: loginEvent, loginButtonEnabled: loginButtonEnabled)
        
        super.init()
    }
}
