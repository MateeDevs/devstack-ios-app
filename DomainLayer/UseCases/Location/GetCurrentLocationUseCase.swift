//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import RxSwift

public protocol HasGetCurrentLocationUseCase {
    var getCurrentLocationUseCase: GetCurrentLocationUseCaseType { get }
}

public protocol GetCurrentLocationUseCaseType {
    func execute() -> Observable<CLLocation>
}

public struct GetCurrentLocationUseCase: GetCurrentLocationUseCaseType {
    
    public typealias Dependencies = HasLocationRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() -> Observable<CLLocation> {
        return dependencies.locationRepository.getCurrentLocation(withAccuracy: kCLLocationAccuracyThreeKilometers)
    }
}
