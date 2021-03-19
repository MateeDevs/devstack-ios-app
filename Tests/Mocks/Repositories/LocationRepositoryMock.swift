//
//  Created by Petr Chmelar on 18.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import RxSwift

struct LocationRepositoryMock: LocationRepositoryType {
    
    var isLocationEnabledReturnValue: Bool = false
    var getCurrentLocationReturnValue: Observable<CLLocation> = .empty()
    
    func isLocationEnabled() -> Bool {
        return isLocationEnabledReturnValue
    }
    
    func getCurrentLocation(withAccuracy accuracy: CLLocationAccuracy) -> Observable<CLLocation> {
        return getCurrentLocationReturnValue
    }
}
