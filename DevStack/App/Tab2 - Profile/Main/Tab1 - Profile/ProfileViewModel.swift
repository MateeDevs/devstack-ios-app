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
    
    let input: Input
    let output: Output
    
    struct Input {
    }
    
    struct Output {
        let getProfileEvent: Driver<Lce<User>>
        let currentLocation: Driver<CLLocation>
    }
    
    init(dependencies: Dependencies) {
        
        let getProfileEvent = dependencies.userService.getProfile().asDriverOnErrorJustComplete()
        let currentLocation = dependencies.locationManager.getCurrentLocation().take(1).asDriverOnErrorJustComplete()
        
        self.input = Input()
        self.output = Output(getProfileEvent: getProfileEvent, currentLocation: currentLocation)
        
        super.init()
    }
}
