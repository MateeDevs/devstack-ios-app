//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import RxSwift

struct GetCurrentLocationUseCaseMock: GetCurrentLocationUseCaseType {
    var returnValue: Observable<CLLocation>
    
    func execute() -> Observable<CLLocation> {
        return returnValue
    }
}
