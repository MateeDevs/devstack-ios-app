//
//  Realm+Rx.swift
//  DevStack
//
//  Created by Petr Chmelar on 07/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import RealmSwift
import RxRealm
import RxSwift

extension Reactive where Base == Realm {
    func save<T: Object>(_ object: T, model: UpdateModel = .apiModel) -> Observable<T> {
        Observable.create { observer in
            do {
                try self.base.write {
                    self.base.create(T.self, value: model.value(for: object), update: .modified)
                }
                observer.onNext(object)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func save<T: Object>(_ objects: [T], model: UpdateModel = .apiModel) -> Observable<[T]> {
        Observable.create { observer in
            do {
                try self.base.write {
                    for object in objects {
                        self.base.create(T.self, value: model.value(for: object), update: .modified)
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
    
    func appendToList<T: Object>(_ list: List<T>, objects: [T], model: UpdateModel = .apiModel) -> Observable<[T]> {
        Observable.create { observer in
            do {
                try self.base.write {
                    // It's not possible to append objects directly (nested objects won't be updated)
                    // Instead we have to append a reference for every object
                    // Idea taken from: https://stackoverflow.com/a/40595430
                    for object in objects {
                        self.base.create(T.self, value: model.value(for: object), update: .modified)
                        
                        // Append reference if it isn't already in the list
                        if let objectReference = self.base.object(ofType: T.self, forPrimaryKey: object["id"]) {
                            let listIds = list.toArray().map { $0["id"] as? String }
                            if !listIds.contains(object["id"] as? String) {
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
