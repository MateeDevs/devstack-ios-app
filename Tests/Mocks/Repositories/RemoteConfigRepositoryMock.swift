//
//  Created by Petr Chmelar on 18.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct RemoteConfigRepositoryMock: RemoteConfigRepositoryType {
    
    var readReturnValue: Observable<Bool> = .empty()
    
    func read(_ key: RemoteConfigCoding) -> Observable<Bool> {
        return readReturnValue
    }
}
