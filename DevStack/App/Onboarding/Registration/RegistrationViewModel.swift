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
    fileprivate let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    struct Input {
        let email: Driver<String>
        let password: Driver<String>
        let registerButtonTaps: Signal<()>
    }

    struct Output {
        let registrationEvent: Driver<Lce<User>>
        let registerButtonEnabled: Driver<Bool>
    }

    func transform(input: Input) -> Output {
        let activity = ActivityIndicator()
        let inputs = Driver.combineLatest(input.email, input.password) { (email: $0, password: $1) }

        let registrationEvent = input.registerButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Driver<Lce<User>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
				return Driver.just(Lce(error: ValidationError(L10n.invalid_credentials)))
            } else if !DataValidator.validateEmail(inputs.email) {
				return Driver.just(Lce(error: ValidationError(L10n.invalid_email)))
            } else {
                return self.dependencies.loginService.registration(email: inputs.email, password: inputs.password, firstName: "Anonymous", lastName: "")
                    .trackActivity(activity)
                    .asDriverOnErrorJustComplete()
            }
        }

        let registerButtonEnabled = activity.asDriver().map({ (activity) -> Bool in
            !activity
        })

        return Output(registrationEvent: registrationEvent, registerButtonEnabled: registerButtonEnabled)
    }
}
