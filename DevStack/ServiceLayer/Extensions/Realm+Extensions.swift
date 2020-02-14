//
//  Realm+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 07/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

extension ObservableType {

    ///
    /// Transformation that saves an object to the database.
    ///
    /// - parameter setPrimaryKey: Optional parameter to set object's primary key (useful for foreign key).
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - returns: Observable which emits saved object.
    ///
    func save<T: Object>(setPrimaryKey: String? = nil, primaryKeyName: String = "id") -> Observable<T> where E == T {
        flatMap({ (object) -> Observable<T> in
            if let id = setPrimaryKey {
                object[primaryKeyName] = id
            }
            let realm = try! Realm()
            return realm.rx.save(object)
        })
    }

    ///
    /// Transformation that saves an array of objects to the database.
    ///
    /// - returns: Observable which emits saved array.
    ///
    func save<T: Object>() -> Observable<[T]> where E == [T] {
        flatMap({ (objects) -> Observable<[T]> in
            let realm = try! Realm()
            return realm.rx.save(objects)
        })
    }

    ///
    /// Transformation that append an object to a given list and saves it to the database.
    ///
    /// - parameter list: List that will be extented with new object.
    /// - parameter setPrimaryKey: Optional parameter to set object's primary key (useful for foreign key).
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - returns: Observable which emits saved object.
    ///
    func appendToList<T: Object>(_ list: List<T>, setPrimaryKey: String? = nil, primaryKeyName: String = "id") -> Observable<T> where E == T {
        flatMap({ (object) -> Observable<T> in
            if let id = setPrimaryKey {
                object[primaryKeyName] = id
            }
            let realm = try! Realm()
            return realm.rx.appendToList(list, objects: [object]).map({ _ in object })
        })
    }

    ///
    /// Transformation that append all objects from an array to a given list and saves it to the database.
    ///
    /// - parameter list: List that will be extented with new objects.
    /// - returns: Observable which emits saved array.
    ///
    func appendToList<T: Object>(_ list: List<T>) -> Observable<[T]> where E == [T] {
        flatMap({ (objects) -> Observable<[T]> in
            let realm = try! Realm()
            return realm.rx.appendToList(list, objects: objects).map({ _ in objects })
        })
    }

}

extension Reactive where Base: Realm {
    func save<T: Object>(_ object: T, withApiModel: Bool = true) -> Observable<T> {
        Observable.create { observer in
            do {
                try self.base.write {
                    // Create new object if it doesn't exists or partially update existing one
                    if !object.exists() {
                        self.base.add(object, update: .modified)
                    } else {
                        self.base.create(T.self, value: withApiModel ? object.apiModel() : object.fullModel(), update: .modified)
                    }
                }
                observer.onNext(object)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func save<T: Object>(_ objects: [T], withApiModel: Bool = true) -> Observable<[T]> {
        Observable.create { observer in
            do {
                try self.base.write {
                    for object in objects {
                        // Create new object if it doesn't exists or partially update existing one
                        if !object.exists() {
                            self.base.add(object, update: .modified)
                        } else {
                            self.base.create(T.self, value: withApiModel ? object.apiModel() : object.fullModel(), update: .modified)
                        }
                    }
                }
                observer.onNext(objects)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func appendToList<T: Object>(_ list: List<T>, objects: [T], withApiModel: Bool = true) -> Observable<[T]> {
        Observable.create { observer in
            do {
                try self.base.write {
                    // It's not possible to append objects directly (nested objects won't be updated)
                    // Instead we have to append a reference for every object
                    // Idea taken from: https://stackoverflow.com/a/40595430
                    for object in objects {
                        // Create new object if it doesn't exists or partially update existing one
                        if !object.exists() {
                            self.base.add(object, update: .modified)
                        } else {
                            self.base.create(T.self, value: withApiModel ? object.apiModel() : object.fullModel(), update: .modified)
                        }
                        // Append reference if it isn't already in the list
                        if let objectReference = self.base.object(ofType: T.self, forPrimaryKey: object["id"]) {
                            let listIds = list.toArray().map { $0["id"] as! String }
                            if !listIds.contains(object["id"] as! String) {
                                list.append(objectReference)
                            }
                        }
                    }
                }
                observer.onNext(list.toArray())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func delete<T: Object>(_ object: T) -> Observable<Void> {
        Observable.create { observer in
            do {
                try self.base.write {
                    self.base.delete(object)
                }
                observer.onNext(Void())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
