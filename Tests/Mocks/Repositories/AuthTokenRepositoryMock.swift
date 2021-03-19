//
//  Created by Petr Chmelar on 18.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct AuthTokenRepositoryMock: AuthTokenRepositoryType {

    var createReturnValue: Observable<AuthToken> = .empty()
    var readReturnValue: AuthToken?
    
    func create(_ data: LoginData) -> Observable<AuthToken> {
        return createReturnValue
    }
    
    func read() -> AuthToken? {
        return readReturnValue
    }
    
    func delete() {}
}
