//
//  Created by Petr Chmelar on 16.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct LoginUseCaseMock: LoginUseCaseType {
    var returnValue: Observable<Void>
    
    func execute(_ data: LoginData) -> Observable<Void> {
        return returnValue
    }
}
