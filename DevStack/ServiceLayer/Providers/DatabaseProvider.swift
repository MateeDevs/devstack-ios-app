//
//  DatabaseProvider.swift
//  DevStack
//
//  Created by Petr Chmelar on 14/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

struct DatabaseProvider {
    
    ///
    /// Generic function for observing on a specified object from database.
    ///
    /// - parameter type: Type of object.
    /// - parameter id: Primary key to specify an object.
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - returns: Observable which emits an object of a given type.
    ///
    func observableObject<T: Object>(
        _ type: T.Type,
        id: String,
        primaryKeyName: String = "id"
    ) -> Observable<T> {
        guard let realm = Realm.safeInit() else { return Observable.error(CommonError.realmNotAvailable) }
        let dbObjects = realm.objects(T.self).filter(NSPredicate(format: "\(primaryKeyName) == %@", id))
        
        return Observable.collection(from: dbObjects).flatMap { objects -> Observable<T> in
            guard let object = objects.first else { return Observable.empty() }
            return Observable.just(object)
        }
    }
    
    ///
    /// Generic function for observing on a specified collection of objects from database.
    ///
    /// - parameter type: Type of objects.
    /// - parameter predicate: NSPredicate for optional objects filtering.
    /// - parameter sortBy: Optional parameter for sorting.
    /// - parameter ascending: Optional parameter for sorting in ascending or descending order.
    /// - returns: Observable which emits an Array of objects of a given type.
    ///
    func observableCollection<T: Object>(
        _ type: T.Type,
        predicate: NSPredicate? = nil,
        sortBy: String? = nil,
        ascending: Bool = true
    ) -> Observable<[T]> {
        guard let realm = Realm.safeInit() else { return Observable.error(CommonError.realmNotAvailable) }
        var dbObjects = realm.objects(T.self)
        
        if let predicate = predicate {
            dbObjects = dbObjects.filter(predicate)
        }
        
        if let sortBy = sortBy {
            dbObjects = dbObjects.sorted(byKeyPath: sortBy, ascending: ascending)
        }
        
        return Observable.array(from: dbObjects).flatMap { objects -> Observable<[T]> in
            guard !objects.isEmpty else { return Observable.just([]) }
            return Observable.just(objects)
        }
    }
    
}