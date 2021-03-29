//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasUserRepository {
    var userRepository: UserRepositoryType { get }
}

public protocol UserRepositoryType: AutoMockable {
    func create(_ data: RegistrationData) -> Observable<User>
    func read(_ sourceType: SourceType, id: String) -> Observable<User>
    func list(_ sourceType: SourceType, page: Int, sortBy: String?) -> Observable<[User]>
    func update(_ sourceType: SourceType, user: User) -> Observable<User>
}
