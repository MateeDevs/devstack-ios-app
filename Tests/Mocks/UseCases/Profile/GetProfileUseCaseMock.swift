//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct GetProfileUseCaseMock: GetProfileUseCaseType {
    var returnValue: Observable<User>
    
    func execute() -> Observable<User> {
        return returnValue
    }
}
