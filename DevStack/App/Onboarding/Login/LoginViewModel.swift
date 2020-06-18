//
//  LoginViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

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
        let login: Driver<Lce<Void>>
    }
    
    init(dependencies: Dependencies) {
        let email = ReplaySubject<String>.create(bufferSize: 1)
        let password = ReplaySubject<String>.create(bufferSize: 1)
        let loginButtonTaps = PublishSubject<Void>()
        
        let inputs = Observable.combineLatest(email, password) { (email: $0, password: $1) }
        
        let login = loginButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Observable<Lce<Void>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
                return Observable.just(.error(ValidationError(L10n.invalid_credentials)))
            } else {
                let errors = ErrorMessages([401: L10n.invalid_credentials], defaultMessage: L10n.signing_failed)
                
                return dependencies.loginService.login(
                    email: inputs.email,
                    password: inputs.password
                ).mapToLce(errors)
            }
        }.asDriverOnErrorJustComplete()
        
        self.input = Input(
            email: email.asObserver(),
            password: password.asObserver(),
            loginButtonTaps: loginButtonTaps.asObserver()
        )
        
        self.output = Output(
            login: login
        )
        
        super.init()
    }
}
