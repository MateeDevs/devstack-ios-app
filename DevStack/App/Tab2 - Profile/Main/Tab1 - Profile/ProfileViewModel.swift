//
//  ProfileViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreLocation

final class ProfileViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasUserService & HasLocationManager
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
    }
    
    struct Input {
    }
    
    struct Output {
        let getProfileEvent: Driver<Lce<User>>
        let currentLocation: Observable<CLLocation>
    }
    
    func transform(input: Input) -> Output {
        let getProfileEvent = dependencies.userService.getProfile().asDriverOnErrorJustComplete()
        let currentLocation = dependencies.locationManager.getCurrentLocation()
        return Output(getProfileEvent: getProfileEvent, currentLocation: currentLocation)
    }
}
