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

protocol HasDatabaseProvider {
    var databaseProvider: DatabaseProviderType { get }
}

public protocol DatabaseProviderType {

    ///
    /// Generic function for observing on a specified object from database.
    ///
    /// - parameter type: Type of object.
    /// - parameter id: Primary key to specify an object.
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - returns: Observable which emits an object of a given type.
    ///
    func observableObject<T: Object>(_ type: T.Type, id: String, primaryKeyName: String) -> Observable<T>
    
    ///
    /// Generic function for observing on a specified collection of objects from database.
    ///
    /// - parameter type: Type of objects.
    /// - parameter predicate: NSPredicate for optional objects filtering.
    /// - parameter sortBy: Optional parameter for sorting.
    /// - parameter ascending: Optional parameter for sorting in ascending or descending order.
    /// - returns: Observable which emits an Array of objects of a given type.
    ///
    func observableCollection<T: Object>(_ type: T.Type, predicate: NSPredicate?, sortBy: String?, ascending: Bool) -> Observable<[T]>

    /// Delete all records
    func deleteAll()
}

extension DatabaseProviderType {
    
    func observableObject<T: Object>(
        _ type: T.Type,
        id: String,
        primaryKeyName: String = "id"
    ) -> Observable<T> {
        observableObject(type, id: id, primaryKeyName: primaryKeyName)
    }
    
    func observableCollection<T: Object>(
        _ type: T.Type,
        predicate: NSPredicate? = nil,
        sortBy: String? = nil,
        ascending: Bool = true
    ) -> Observable<[T]> {
        observableCollection(type, predicate: predicate, sortBy: sortBy, ascending: ascending)
    }
}

struct DatabaseProvider: DatabaseProviderType {
    
    func observableObject<T: Object>(_ type: T.Type, id: String, primaryKeyName: String) -> Observable<T> {
        guard let realm = Realm.safeInit() else { return Observable.error(CommonError.realmNotAvailable) }
        let dbObjects = realm.objects(T.self).filter(NSPredicate(format: "\(primaryKeyName) == %@", id))
        
        return Observable.collection(from: dbObjects).flatMap { objects -> Observable<T> in
            guard let object = objects.first else { return Observable.empty() }
            return Observable.just(object)
        }
    }

    func observableCollection<T: Object>(_ type: T.Type, predicate: NSPredicate?, sortBy: String?, ascending: Bool) -> Observable<[T]> {
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

    func deleteAll() {
        guard let realm = Realm.safeInit() else { return }
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            Logger.error("Error during Realm deleteAll operation:\n%@", "\(error)", category: .app)
        }
    }
}
