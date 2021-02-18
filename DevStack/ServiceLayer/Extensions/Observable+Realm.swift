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
    
    /// Transformation that saves an object to the database.
    func save<T>(model: UpdateModel = .apiModel) -> Observable<T> where T: DatabaseRepresentable, T.DatabaseModel: Object, T == Element {
        flatMap { object -> Observable<T> in
            guard let realm = Realm.safeInit() else { return .error(CommonError.realmNotAvailable) }
            return realm.rx.save(object, model: model)
        }
    }
    
    /// Transformation that saves an array of objects to the database.
    func save<T>(model: UpdateModel = .apiModel) -> Observable<[T]> where T: DatabaseRepresentable, T.DatabaseModel: Object, [T] == Element {
        flatMap { objects -> Observable<[T]> in
            guard let realm = Realm.safeInit() else { return .error(CommonError.realmNotAvailable) }
            return realm.rx.save(objects, model: model)
        }
    }
    
}
