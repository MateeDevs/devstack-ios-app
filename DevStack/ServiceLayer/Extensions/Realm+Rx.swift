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
    func save<T>(_ object: T, model: UpdateModel = .apiModel) -> Observable<T> where T: DatabaseRepresentable, T.DatabaseModel: Object {
        .create { observer in
            do {
                try self.base.write {
                    self.base.create(T.DatabaseModel.self, value: model.value(for: object.databaseModel), update: .modified)
                }
                observer.onNext(object)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func save<T>(_ objects: [T], model: UpdateModel = .apiModel) -> Observable<[T]> where T: DatabaseRepresentable, T.DatabaseModel: Object {
        .create { observer in
            do {
                try self.base.write {
                    for object in objects {
                        self.base.create(T.DatabaseModel.self, value: model.value(for: object.databaseModel), update: .modified)
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
}
