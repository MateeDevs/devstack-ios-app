//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class DatabaseProviderMock: DatabaseProvider {
    
    var observableObjectCallsCount = 0
    var observableObjectReturnValue: Object?
    
    var observableCollectionCallsCount = 0
    var observableCollectionReturnValue: [Object] = []
    
    var saveObjectCallsCount = 0
    var saveCollectionCallsCount = 0
    var deleteAllCallsCount = 0

    func observableObject<T>(
        _ type: T.Type,
        id: String,
        primaryKeyName: String
    ) -> Observable<T> where T: Object {
        guard let object = observableObjectReturnValue as? T else { return .empty() }
        return Observable.just(object).do { _ in self.observableObjectCallsCount += 1 }
    }

    func observableCollection<T>(
        _ type: T.Type,
        predicate: NSPredicate?,
        sortBy: String?,
        ascending: Bool
    ) -> Observable<[T]> where T: Object {
        guard let collection = observableCollectionReturnValue as? [T] else { return .empty() }
        return Observable.just(collection).do { _ in self.observableCollectionCallsCount += 1 }
    }
    
    func save<T>(_ object: T, model: UpdateModel) -> Observable<T> where T: Object {
        return Observable.just(object).do { _ in self.saveObjectCallsCount += 1 }
    }
    
    func save<T>(_ objects: [T], model: UpdateModel) -> Observable<[T]> where T: Object {
        return Observable.just(objects).do { _ in self.saveCollectionCallsCount += 1 }
    }

    func deleteAll() {
        deleteAllCallsCount += 1
    }
}
