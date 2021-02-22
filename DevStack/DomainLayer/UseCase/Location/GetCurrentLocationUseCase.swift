//
//  GetCurrentLocationUseCase.swift
//  DevStack
//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import RxSwift

public protocol HasGetCurrentLocationUseCase {
    var getCurrentLocationUseCase: GetCurrentLocationUseCase { get }
}

public struct GetCurrentLocationUseCase {
    
    typealias Dependencies = HasLocationRepository
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() -> Observable<CLLocation> {
        return dependencies.locationRepository.getCurrentLocation()
    }
}
