//
//  RegistrationViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 05/03/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

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
        let registrationSuccess: Driver<User>
        let registerButtonEnabled: Driver<Bool>
        let whisperAction: Driver<WhisperAction>
    }
    
    init(dependencies: Dependencies) {
        
        // MARK: Setup inputs
        
        let email = ReplaySubject<String>.create(bufferSize: 1)
        let password = ReplaySubject<String>.create(bufferSize: 1)
        let registerButtonTaps = PublishSubject<Void>()
        
        self.input = Input(
            email: email.asObserver(),
            password: password.asObserver(),
            registerButtonTaps: registerButtonTaps.asObserver()
        )
        
        // MARK: Setup outputs
        
        let activity = ActivityIndicator()
        
        let inputs = Observable.combineLatest(email, password) { (email: $0, password: $1) }
        
        let registration = registerButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Observable<Event<User>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
                return Observable.just(.error(ValidationError(L10n.invalid_credentials)))
            } else if !DataValidator.validateEmail(inputs.email) {
                return Observable.just(.error(ValidationError(L10n.invalid_email)))
            } else {
                return dependencies.loginService.registration(
                    email: inputs.email,
                    password: inputs.password,
                    firstName: "Anonymous",
                    lastName: ""
                ).trackActivity(activity).materialize()
            }
        }.share()
        
    let messages = ErrorMessages([.httpConflict: L10n.register_view_email_already_exists], defaultMessage: L10n.signing_up_failed)
        
        let whisperAction: Observable<WhisperAction> = Observable.merge(
            activity.mapToWhisperAction(L10n.signing_up),
            registration.compactMap { $0.element }.map { _ in .hide },
            registration.compactMap { $0.error }.map { .showError($0.toString(messages)) }
        )
        
        self.output = Output(
            registrationSuccess: registration.compactMap { $0.element }.asDriver(),
            registerButtonEnabled: activity.map { !$0 },
            whisperAction: whisperAction.asDriver()
        )
        
        super.init()
    }
}
