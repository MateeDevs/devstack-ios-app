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
    
    typealias Dependencies = HasUserService & HasLocationService
    
    let input: Input
    let output: Output
    
    struct Input {
    }
    
    struct Output {
        let profile: Driver<Lce<User>>
        let currentLocation: Driver<CLLocation>
    }
    
    init(dependencies: Dependencies) {
        // Merge db and network stream
        let getProfile = dependencies.userService.getProfile().mapToLce()
        let downloadProfile = dependencies.userService.downloadProfile().mapToLce().filterErrors()
        let profile = Observable.merge(getProfile, downloadProfile).asDriverOnErrorJustComplete()
        
        let currentLocation = dependencies.locationService.getCurrentLocation().take(1).asDriverOnErrorJustComplete()
        
        self.input = Input()
        
        self.output = Output(
            profile: profile,
            currentLocation: currentLocation
        )
        
        super.init()
    }
}
