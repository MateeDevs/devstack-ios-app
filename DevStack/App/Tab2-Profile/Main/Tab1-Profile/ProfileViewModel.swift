//
//  ProfileViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import CoreLocation
import RxCocoa
import RxSwift

final class ProfileViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasUserService & HasLoginService & HasLocationService
    
    let input: Input
    let output: Output
    
    struct Input {
        let logoutButtonTaps: AnyObserver<Void>
        let increaseButtonTaps: AnyObserver<Void>
        let decreaseButtonTaps: AnyObserver<Void>
    }
    
    struct Output {
        let profile: Profile
        let isRefreshing: Driver<Bool>
        let currentLocation: Driver<CLLocation>
        let logoutSuccess: Driver<Void>
        let increaseCounter: Driver<User>
        let decreaseCounter: Driver<User>
    }

    struct Profile {
        let fullName: Driver<String>
        let initials: Driver<String>
        let imageURL: Driver<String?>
        let counterValue: Driver<String>
    }
    
    init(dependencies: Dependencies) {
        
        // MARK: Setup inputs

        let logoutButtonTaps = PublishSubject<Void>()
        let increaseButtonTaps = PublishSubject<Void>()
        let decreaseButtonTaps = PublishSubject<Void>()
        
        self.input = Input(
            logoutButtonTaps: logoutButtonTaps.asObserver(),
            increaseButtonTaps: increaseButtonTaps.asObserver(),
            decreaseButtonTaps: decreaseButtonTaps.asObserver()
        )
        
        // MARK: Transformations
        
        let activity = ActivityIndicator()

        let profile = dependencies.userService.getProfile()
        let refreshProfile = dependencies.userService.downloadProfile().trackActivity(activity).materialize().share()
        
        let isRefreshing: Observable<Bool> = Observable.merge(
            activity.asObservable(),
            refreshProfile.map { _ in false }
        )
        
        let currentLocation = dependencies.locationService.getCurrentLocation().take(1)

        let logout = logoutButtonTaps.flatMapLatest { _ -> Observable<Event<Void>> in
            return dependencies.loginService.logout().materialize()
        }.share()

        let increaseCounter = increaseButtonTaps.flatMapLatest { _ -> Observable<Event<User>> in
            return dependencies.userService.increaseCounter().materialize()
        }.share()

        let decreaseCounter = decreaseButtonTaps.flatMapLatest { _ -> Observable<Event<User>> in
            return dependencies.userService.decreaseCounter().materialize()
        }.share()

        // MARK: Setup outputs
        
        self.output = Output(
            profile: Profile(
                fullName: profile.map { $0.fullName }.asDriver(),
                initials: profile.map { $0.fullName.initials }.asDriver(),
                imageURL: profile.map { $0.pictureUrl }.asDriver(),
                counterValue: profile.map { "\($0.counter)" }.asDriver()
            ),
            isRefreshing: isRefreshing.asDriver(),
            currentLocation: currentLocation.asDriver(),
            logoutSuccess: logout.compactMap { $0.element }.asDriver(),
            increaseCounter: increaseCounter.compactMap { $0.element }.asDriver(),
            decreaseCounter: decreaseCounter.compactMap { $0.element }.asDriver()
        )
        
        super.init()
    }
}
