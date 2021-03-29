//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RealmSwift
import RxSwift

class DatabaseProviderMock: DatabaseProvider {
    
    var observableObjectCallsCount = 0
    var observableObjectReturnValue: Observable<Object> = .empty()
    
    var observableCollectionCallsCount = 0
    var observableCollectionReturnValue: Observable<[Object]> = .empty()
    
    var saveObjectCallsCount = 0
    var saveObjectReturnValue: Observable<Object> = .empty()
    
    var saveCollectionCallsCount = 0
    var saveCollectionReturnValue: Observable<[Object]> = .empty()
    
    var deleteAllCallsCount = 0

    func observableObject<T>(
        _ type: T.Type,
        id: String,
        primaryKeyName: String
    ) -> Observable<T> where T: Object {
        observableObjectCallsCount += 1
        guard let observableObjectReturnValue = observableObjectReturnValue as? Observable<T> else { return .empty() }
        return observableObjectReturnValue
    }

    func observableCollection<T>(
        _ type: T.Type,
        predicate: NSPredicate?,
        sortBy: String?,
        ascending: Bool
    ) -> Observable<[T]> where T: Object {
        observableCollectionCallsCount += 1
        guard let observableCollectionReturnValue = observableCollectionReturnValue as? Observable<[T]> else { return .empty() }
        return observableCollectionReturnValue
    }
    
    func save<T>(_ object: T, model: UpdateModel) -> Observable<T> where T: Object {
        saveObjectCallsCount += 1
        guard let saveObjectReturnValue = saveObjectReturnValue as? Observable<T> else { return .empty() }
        return saveObjectReturnValue
    }
    
    func save<T>(_ objects: [T], model: UpdateModel) -> Observable<[T]> where T: Object {
        saveCollectionCallsCount += 1
        guard let saveCollectionReturnValue = saveCollectionReturnValue as? Observable<[T]> else { return .empty() }
        return saveCollectionReturnValue
    }

    func deleteAll() {
        deleteAllCallsCount += 1
    }
}
