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
        let email: BehaviorRelay<String>
        let password: BehaviorRelay<String>
        let loginButtonTaps: AnyObserver<Void>
    }
    
    struct Output {
        let loginSuccess: Driver<Void>
        let loginButtonEnabled: Driver<Bool>
        let alertAction: Driver<AlertAction>
    }
    
    init(dependencies: Dependencies) {
        
        // MARK: Setup inputs
        
        let email = BehaviorRelay<String>(value: "")
        let password = BehaviorRelay<String>(value: "")
        let loginButtonTaps = PublishSubject<Void>()
        
        self.input = Input(
            email: email,
            password: password,
            loginButtonTaps: loginButtonTaps.asObserver()
        )

        // MARK: Transformations
        
        let activity = ActivityIndicator()
        
        let inputs = Observable.combineLatest(email, password) { (email: $0, password: $1) }
        
        let login = loginButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Observable<Event<Void>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
                return Observable.just(.error(ValidationError(L10n.invalid_credentials)))
            } else {
                return dependencies.loginService.login(
                    email: inputs.email,
                    password: inputs.password
                ).trackActivity(activity).materialize()
            }
        }.share()
        
        let messages = ErrorMessages([.httpUnathorized: L10n.invalid_credentials], defaultMessage: L10n.signing_failed)
        
        let alertAction: Observable<AlertAction> = Observable.merge(
            activity.toWhisper(L10n.signing_in),
            login.compactMap { $0.element }.map { .hideWhisper },
            login.compactMap { $0.error }.map { .showWhisper(Whisper(error: $0.toString(messages))) }
        )

        // MARK: Setup outputs
        
        self.output = Output(
            loginSuccess: login.compactMap { $0.element }.asDriver(),
            loginButtonEnabled: activity.map { !$0 },
            alertAction: alertAction.asDriver()
        )
        
        super.init()
    }
}
