//
//  Created by Petr Chmelar on 18.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

struct UserRepositoryMock: UserRepositoryType {
    
    var createReturnValue: Observable<User> = .empty()
    var readReturnValue: Observable<User> = .empty()
    var listReturnValue: Observable<[User]> = .empty()
    var updateReturnValue: Observable<User> = .empty()
    
    func create(_ data: RegistrationData) -> Observable<User> {
        return createReturnValue
    }
    
    func read(_ sourceType: SourceType, id: String) -> Observable<User> {
        return readReturnValue
    }
    
    func list(_ sourceType: SourceType, page: Int, sortBy: String?) -> Observable<[User]> {
        return listReturnValue
    }
    
    func update(_ sourceType: SourceType, user: User) -> Observable<User> {
        return updateReturnValue
    }
}
