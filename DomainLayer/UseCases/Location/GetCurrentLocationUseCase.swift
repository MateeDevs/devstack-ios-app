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
    
    public typealias Dependencies = HasLocationRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func execute() -> Observable<CLLocation> {
        return dependencies.locationRepository.getCurrentLocation(withAccuracy: kCLLocationAccuracyThreeKilometers)
    }
}
