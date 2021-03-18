//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct UpdateUserUseCaseMock: UpdateUserUseCaseType {
    var returnValue: Observable<Void> = .empty()
    
    func execute(user: User) -> Observable<Void> {
        return returnValue
    }
}
