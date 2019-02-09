//
//  Realm+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 07/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

extension ObservableType {
    
    ///
    /// Transformation that unwraps an object from Lce and saves it to the database.
    ///
    /// - parameter setPrimaryKey: Optional parameter to set object's primary key (useful for foreign key).
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - returns: Observable which emits Lce of a given type.
    ///
    func save<T: Object>(setPrimaryKey: String? = nil, primaryKeyName: String = "id") -> Observable<Lce<T>> where E == Lce<T> {
        return flatMap({ (event) -> Observable<Lce<T>> in
            guard let object = event.data else { return Observable.just(event) }
            if let id = setPrimaryKey {
                object[primaryKeyName] = id
            }
            let realm = try! Realm()
            return realm.rx.save(object)
        }).catchError({ (error) in error.asServiceError() })
    }
    
    ///
    /// Transformation that unwraps an array of objects from Lce and saves it to the database.
    ///
    /// - returns: Observable which emits Lce with Array of a given type.
    ///
    func save<T: Object>() -> Observable<Lce<[T]>> where E == Lce<[T]> {
        return flatMap({ (event) -> Observable<Lce<[T]>> in
            guard let objects = event.data else { return Observable.just(event) }
            let realm = try! Realm()
            return realm.rx.save(objects)
        }).catchError({ (error) in error.asServiceError() })
    }
    
    ///
    /// Transformation that unwraps an object from Lce, append it to a given list and saves it to the database.
    ///
    /// - parameter list: List that will be extented with new object.
    /// - parameter setPrimaryKey: Optional parameter to set object's primary key (useful for foreign key).
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - returns: Observable which emits Lce of a given type.
    ///
    func appendToList<T: Object>(_ list: List<T>, setPrimaryKey: String? = nil, primaryKeyName: String = "id") -> Observable<Lce<T>> where E == Lce<T> {
        return flatMap({ (event) -> Observable<Lce<T>> in
            guard let object = event.data else { return Observable.just(event) }
            if let id = setPrimaryKey {
                object[primaryKeyName] = id
            }
            let realm = try! Realm()
            return realm.rx.appendToList(list, objects: [object]).map({ _ in Lce<T>(data: object) })
        }).catchError({ (error) in error.asServiceError() })
    }
    
    ///
    /// Transformation that unwraps an array of objects from Lce, append it to a given list and saves it to the database.
    ///
    /// - parameter list: List that will be extented with new objects.
    /// - returns: Observable which emits Lce with Array of a given type.
    ///
    func appendToList<T: Object>(_ list: List<T>) -> Observable<Lce<[T]>> where E == Lce<[T]> {
        return flatMap({ (event) -> Observable<Lce<[T]>> in
            guard let objects = event.data else { return Observable.just(event) }
            let realm = try! Realm()
            return realm.rx.appendToList(list, objects: objects).map({ _ in Lce<[T]>(data: objects) })
        }).catchError({ (error) in error.asServiceError() })
    }
    
}

extension Reactive where Base: Realm {
    func save<T: Object>(_ object: T, update: Bool = true, withApiModel: Bool = true) -> Observable<Lce<T>> {
        return Observable.create { observer in
            do {
                try self.base.write {
                    // Create new object if it doesn't exists or partially update existing one
                    if !object.exists() {
                        self.base.add(object, update: update)
                    } else {
                        self.base.create(T.self, value: withApiModel ? object.apiModel() : object.fullModel(), update: update)
                    }
                }
                observer.onNext(Lce<T>(data: object))
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func save<T: Object>(_ objects: [T], update: Bool = true, withApiModel: Bool = true) -> Observable<Lce<[T]>> {
        return Observable.create { observer in
            do {
                try self.base.write {
                    for object in objects {
                        // Create new object if it doesn't exists or partially update existing one
                        if !object.exists() {
                            self.base.add(object, update: update)
                        } else {
                            self.base.create(T.self, value: withApiModel ? object.apiModel() : object.fullModel(), update: update)
                        }
                    }
                }
                observer.onNext(Lce<[T]>(data: objects))
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func appendToList<T: Object>(_ list: List<T>, objects: [T], update: Bool = true, withApiModel: Bool = true) -> Observable<Lce<[T]>> {
        return Observable.create { observer in
            do {
                try self.base.write {
                    // It's not possible to append objects directly (nested objects won't be updated)
                    // Instead we have to append a reference for every object
                    // Idea taken from: https://stackoverflow.com/a/40595430/6947225
                    for object in objects {
                        // Create new object if it doesn't exists or partially update existing one
                        if !object.exists() {
                            self.base.add(object, update: update)
                        } else {
                            self.base.create(T.self, value: withApiModel ? object.apiModel() : object.fullModel(), update: update)
                        }
                        // Append reference if it isn't already in the list
                        if let objectReference = self.base.object(ofType: T.self, forPrimaryKey: object["id"]) {
                            let listIds = list.toArray().map { $0["id"] as! Int }
                            if !listIds.contains(object["id"] as! Int) {
                                list.append(objectReference)
                            }
                        }
                    }
                }
                observer.onNext(Lce<[T]>(data: list.toArray()))
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func delete<T: Object>(_ object: T) -> Observable<Lce<Void>> {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.delete(object)
                }
                observer.onNext(Lce<Void>(data: Void()))
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
