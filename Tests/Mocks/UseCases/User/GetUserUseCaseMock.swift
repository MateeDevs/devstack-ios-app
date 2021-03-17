//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct GetUserUseCaseMock: GetUserUseCaseType {
    var returnValue: Observable<User>
    
    func execute(id: String) -> Observable<User> {
        return returnValue
    }
}
