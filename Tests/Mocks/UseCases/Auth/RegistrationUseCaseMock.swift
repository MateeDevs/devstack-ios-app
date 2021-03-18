//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct RegistrationUseCaseMock: RegistrationUseCaseType {
    var returnValue: Observable<Void> = .empty()
    
    func execute(_ data: RegistrationData) -> Observable<Void> {
        return returnValue
    }
}
