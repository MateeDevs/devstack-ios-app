//
//  DatabaseManager.swift
//  DevStack
//
//  Created by Petr Chmelar on 14/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

struct DatabaseManager {
    
    ///
    /// Generic function for observing on a specified object from database.
    ///
    /// - parameter id: Primary key to specify an object.
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - returns: Observable which emits Lce of a given type.
    ///
    func observableObject<T: Object>(_ type: T.Type, id: String, primaryKeyName: String = "id") -> Observable<Lce<T>> {
        
        let realm = try! Realm()
        let dbObjects = realm.objects(T.self).filter(NSPredicate(format: "\(primaryKeyName) == %d", id))
        
        return Observable.collection(from: dbObjects).flatMap { (objects) -> Observable<Lce<T>> in
            if let object = objects.first {
                return Observable.just(Lce(data: object))
            } else {
                return Observable.empty()
            }
        }
    }
    
    ///
    /// Generic function for observing on a specified collection of objects from database.
    ///
    /// - parameter predicate: NSPredicate for optional objects filtering.
    /// - parameter sortBy: Optional parameter for sorting.
    /// - parameter ascending: Optional parameter for sorting in ascending or descending order.
    /// - returns: Observable which emits Lce with Array of a given type.
    ///
    func observableCollection<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil, sortBy: String? = nil, ascending: Bool? = nil) -> Observable<Lce<[T]>> {
        
        let realm = try! Realm()
        var dbObjects = realm.objects(T.self)
        
        if let predicate = predicate {
            dbObjects = dbObjects.filter(predicate)
        }
        
        if let sortBy = sortBy, let ascending = ascending {
            dbObjects = dbObjects.sorted(byKeyPath: sortBy, ascending: ascending)
        }
        
        return Observable.array(from: dbObjects).flatMap { (objects) -> Observable<Lce<[T]>> in
            if objects.count > 0 {
                return Observable.just(Lce(data: objects))
            } else {
                return Observable.just(Lce(data: []))
            }
        }
    }
    
}
