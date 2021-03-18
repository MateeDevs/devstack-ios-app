//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct GetRemoteConfigValueUseCaseMock: GetRemoteConfigValueUseCaseType {
    var returnValue: Observable<Bool> = .empty()
    
    func execute(_ key: RemoteConfigCoding) -> Observable<Bool> {
        return returnValue
    }
}
