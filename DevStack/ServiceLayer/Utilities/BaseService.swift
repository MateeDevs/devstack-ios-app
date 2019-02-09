//
//  BaseService.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 09/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RealmSwift
import RxRealm

class BaseService {
    
    let realm = try! Realm()
    let provider = AuthenticatedProvider<MultiTarget>()
    
    ///
    /// Generic function for observing on a specified object from database.
    ///
    /// - parameter id: Primary key to specify an object.
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - returns: Observable which emits Lce of a given type.
    ///
    func dbStream<T: Object>(id: String, primaryKeyName: String = "id") -> Observable<Lce<T>> {
        
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
    func dbStream<T: Object>(predicate: NSPredicate? = nil, sortBy: String? = nil, ascending: Bool? = nil) -> Observable<Lce<[T]>> {
        
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
    
    ///
    /// Generic function for observing on a specified network call.
    /// Automatically filters out API errors and map to an object.
    ///
    /// - parameter endpoint: TargetType from Moya which specify API endpoint to be called.
    /// - parameter atKeyPath: Optional parameter to specify key path for mapping.
    /// - returns: Observable which emits Lce of a given type.
    ///
    func networkStream<T: Decodable>(_ endpoint: TargetType, atKeyPath: String? = nil) -> Observable<Lce<T>> {
        return provider.request(MultiTarget(endpoint)).asObservable().filterSuccess().map(T.self, atKeyPath: atKeyPath).flatMap({ (object) -> Observable<Lce<T>> in
            return Observable.just(Lce<T>(data: object))
        }).catchError({ (error) in error.asServiceError() })
    }
    
    ///
    /// Generic function for observing on a specified network call.
    /// Automatically filters out API errors and map to an array.
    ///
    /// - parameter endpoint: TargetType from Moya which specify API endpoint to be called.
    /// - parameter atKeyPath: Optional parameter to specify key path for mapping.
    /// - returns: Observable which emits Lce with Array of a given type.
    ///
//    func networkStream<T: Decodable>(endpoint: TargetType, atKeyPath: String? = nil) -> Observable<Lce<[T]>> {
//        return provider.request(MultiTarget(endpoint)).asObservable().filterSuccess().map([T].self, atKeyPath: atKeyPath).flatMap({ (objects) -> Observable<Lce<[T]>> in
//            return Observable.just(Lce<[T]>(data: objects))
//        }).catchError({ (error) in error.asServiceError() })
//    }
    
}
