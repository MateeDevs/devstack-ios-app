// 
//  RegistrationViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 05/03/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import RxCocoa

final class RegistrationViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasLoginService
    
    let input: Input
    let output: Output
    
    struct Input {
        let email: AnyObserver<String>
        let password: AnyObserver<String>
        let registerButtonTaps: AnyObserver<Void>
    }
    
    struct Output {
        let registration: Driver<Lce<User>>
    }
    
    init(dependencies: Dependencies) {
        let email = ReplaySubject<String>.create(bufferSize: 1)
        let password = ReplaySubject<String>.create(bufferSize: 1)
        let registerButtonTaps = PublishSubject<Void>()
        
        let inputs = Observable.combineLatest(email, password) { (email: $0, password: $1) }
        
        let registration = registerButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Observable<Lce<User>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
                return Observable.just(.error(ValidationError(L10n.invalid_credentials)))
            } else if !DataValidator.validateEmail(inputs.email) {
                return Observable.just(.error(ValidationError(L10n.invalid_email)))
            } else {
                let errors = ErrorMessages([409: L10n.register_view_email_already_exists], defaultMessage: L10n.signing_up_failed)
                
                return dependencies.loginService.registration(
                    email: inputs.email,
                    password: inputs.password,
                    firstName: "Anonymous",
                    lastName: ""
                ).mapToLce(errors)
            }
        }.asDriverOnErrorJustComplete()
        
        self.input = Input(
            email: email.asObserver(),
            password: password.asObserver(),
            registerButtonTaps: registerButtonTaps.asObserver()
        )
        
        self.output = Output(
            registration: registration
        )
        
        super.init()
    }
}
