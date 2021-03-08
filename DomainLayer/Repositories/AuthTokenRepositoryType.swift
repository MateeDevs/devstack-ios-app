//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasAuthTokenRepository {
    var authTokenRepository: AuthTokenRepositoryType { get }
}

public protocol AuthTokenRepositoryType {
    func create(_ data: LoginData) -> Observable<AuthToken>
    func read() -> AuthToken?
    func delete() -> Observable<Void>
}
