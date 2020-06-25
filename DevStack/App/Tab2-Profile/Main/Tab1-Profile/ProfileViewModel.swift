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
    }
    
    struct Output {
        let profile: Driver<User>
        let isRefreshing: Driver<Bool>
        let currentLocation: Driver<CLLocation>
        let logoutSuccess: Driver<Void>
    }
    
    init(dependencies: Dependencies) {
        
        // MARK: Setup inputs

        let logoutButtonTaps = PublishSubject<Void>()
        
        self.input = Input(
            logoutButtonTaps: logoutButtonTaps.asObserver()
        )
        
        // MARK: Setup outputs
        
        let activity = ActivityIndicator()
        
        // Merge db and network stream for a showcase purpose
        // Prefered way is to use them separately (see UserDetailViewModel)
        let getProfile = dependencies.userService.getProfile()
        let refreshProfile = dependencies.userService.downloadProfile().trackActivity(activity).materialize().share()
        let profile = Observable.merge(getProfile, refreshProfile.compactMap { $0.element })
        
        let isRefreshing: Observable<Bool> = Observable.merge(
            activity.asObservable(),
            refreshProfile.compactMap { $0.element }.map { _ in false },
            refreshProfile.compactMap { $0.error }.map { _ in false }
        )
        
        let currentLocation = dependencies.locationService.getCurrentLocation().take(1)

        let logout = logoutButtonTaps.flatMapLatest { _ -> Observable<Event<Void>> in
            return dependencies.loginService.logout().materialize()
        }.share()
        
        self.output = Output(
            profile: profile.asDriver(),
            isRefreshing: isRefreshing.asDriver(),
            currentLocation: currentLocation.asDriver(),
            logoutSuccess: logout.compactMap { $0.element }.asDriver()
        )
        
        super.init()
    }
}
