//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct UpdateProfileCounterUseCaseMock: UpdateProfileCounterUseCaseType {
    var returnValue: Observable<Void>
    
    func execute(value: Int) -> Observable<Void> {
        return returnValue
    }
}
