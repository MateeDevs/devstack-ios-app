//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RealmSwift
import RxSwift

class DatabaseProviderMock: DatabaseProvider {

    func observableObject<T>(
        _ type: T.Type,
        id: String,
        primaryKeyName: String
    ) -> Observable<T> where T: Object {
        return .empty()
    }

    func observableCollection<T>(
        _ type: T.Type,
        predicate: NSPredicate?,
        sortBy: String?,
        ascending: Bool
    ) -> Observable<[T]> where T: Object {
        return .empty()
    }
    
    func save<T>(_ object: T, model: UpdateModel) -> Observable<T> where T: Object {
        return .empty()
    }
    
    func save<T>(_ objects: [T], model: UpdateModel) -> Observable<[T]> where T: Object {
        return .empty()
    }

    func deleteAll() {
    }
}
