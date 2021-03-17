//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct RefreshProfileUseCaseMock: RefreshProfileUseCaseType {
    var returnValue: Observable<Void>
    
    func execute() -> Observable<Void> {
        return returnValue
    }
}
