//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct RefreshUsersUseCaseMock: RefreshUsersUseCaseType {
    var returnValue: Observable<Int>
    
    func execute(page: Int) -> Observable<Int> {
        return returnValue
    }
}
