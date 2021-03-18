//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct GetUsersUseCaseMock: GetUsersUseCaseType {
    var returnValue: Observable<[User]> = .empty()
    
    func execute() -> Observable<[User]> {
        return returnValue
    }
}
