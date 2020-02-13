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
        let registrationEvent: Driver<Lce<User>>
        let registerButtonEnabled: Driver<Bool>
    }
    
    init(dependencies: Dependencies) {
        let email = ReplaySubject<String>.create(bufferSize: 1)
        let password = ReplaySubject<String>.create(bufferSize: 1)
        let registerButtonTaps = PublishSubject<Void>()
        
        let activity = ActivityIndicator()
        let inputs = Observable.combineLatest(email, password) { (email: $0, password: $1) }
        
        let registrationEvent = registerButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Observable<Lce<User>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
                return Observable.just(Lce(error: ValidationError(L10n.invalid_credentials)))
            } else if !DataValidator.validateEmail(inputs.email) {
                return Observable.just(Lce(error: ValidationError(L10n.invalid_email)))
            } else {
                return dependencies.loginService
                    .registration(email: inputs.email, password: inputs.password, firstName: "Anonymous", lastName: "")
                    .trackActivity(activity)
            }
        }.asDriverOnErrorJustComplete()
        
        let registerButtonEnabled = activity.asDriver().map({ (activity) -> Bool in
            !activity
        })
        
        self.input = Input(email: email.asObserver(), password: password.asObserver(), registerButtonTaps: registerButtonTaps.asObserver())
        self.output = Output(registrationEvent: registrationEvent, registerButtonEnabled: registerButtonEnabled)
        
        super.init()
    }
}
