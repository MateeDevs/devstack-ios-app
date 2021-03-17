//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct RefreshUserUseCaseMock: RefreshUserUseCaseType {
    var returnValue: Observable<Void>
    
    func execute(id: String) -> Observable<Void> {
        return returnValue
    }
}
