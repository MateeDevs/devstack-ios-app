//
//  Observable+Realm.swift
//  DevStack
//
//  Created by Petr Chmelar on 07/08/2018.
//  Copyright © 2020 Matee. All rights reserved.
//

import RealmSwift
import RxSwift

enum UpdateModel {
    case apiModel
    case fullModel
    
    func value(for object: Object) -> Any {
        switch self {
        case .apiModel: return object.apiModel
        case .fullModel: return object.fullModel
        }
    }
}

extension ObservableType {
    
    ///
    /// Transformation that saves an object to the database.
    ///
    /// - parameter setPrimaryKey: Optional parameter to set object's primary key (useful for foreign key).
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - parameter model: Specifies which properties should be updated.
    /// - returns: Observable which emits saved object.
    ///
    func save<T: Object>(
        setPrimaryKey: String? = nil,
        primaryKeyName: String = "id",
        model: UpdateModel = .apiModel
    ) -> Observable<T> where Element == T {
        flatMap({ object -> Observable<T> in
            if let id = setPrimaryKey {
                object[primaryKeyName] = id
            }
            guard let realm = Realm.safeInit() else { return .error(CommonError.realmNotAvailable) }
            return realm.rx.save(object, model: model)
        })
    }
    
    ///
    /// Transformation that saves an array of objects to the database.
    ///
    /// - parameter model: Specifies which properties should be updated.
    /// - returns: Observable which emits saved array.
    ///
    func save<T: Object>(model: UpdateModel = .apiModel) -> Observable<[T]> where Element == [T] {
        flatMap({ objects -> Observable<[T]> in
            guard let realm = Realm.safeInit() else { return .error(CommonError.realmNotAvailable) }
            return realm.rx.save(objects, model: model)
        })
    }
    
    ///
    /// Transformation that append an object to a given list and saves it to the database.
    ///
    /// - parameter list: List that will be extented with new object.
    /// - parameter setPrimaryKey: Optional parameter to set object's primary key (useful for foreign key).
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - parameter model: Specifies which properties should be updated.
    /// - returns: Observable which emits saved object.
    ///
    func appendToList<T: Object>(
        _ list: List<T>,
        setPrimaryKey: String? = nil,
        primaryKeyName: String = "id",
        model: UpdateModel = .apiModel
    ) -> Observable<T> where Element == T {
        flatMap({ object -> Observable<T> in
            if let id = setPrimaryKey {
                object[primaryKeyName] = id
            }
            guard let realm = Realm.safeInit() else { return .error(CommonError.realmNotAvailable) }
            return realm.rx.appendToList(list, objects: [object], model: model).map { _ in object }
        })
    }
    
    ///
    /// Transformation that append all objects from an array to a given list and saves it to the database.
    ///
    /// - parameter list: List that will be extented with new objects.
    /// - parameter model: Specifies which properties should be updated.
    /// - returns: Observable which emits saved array.
    ///
    func appendToList<T: Object>(
        _ list: List<T>,
        model: UpdateModel = .apiModel
    ) -> Observable<[T]> where Element == [T] {
        flatMap({ objects -> Observable<[T]> in
            guard let realm = Realm.safeInit() else { return .error(CommonError.realmNotAvailable) }
            return realm.rx.appendToList(list, objects: objects, model: model).map { _ in objects }
        })
    }
    
}
