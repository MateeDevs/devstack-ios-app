//
//  DatabaseProviderMock.swift
//  DevStack
//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

@testable import A_DevStack

class DatabaseProviderMock: DatabaseProviderType {

    var savedKeys: [UserDefaultsCoding] = []

    func observableObject<T: Object>(_ type: T.Type, id: String, primaryKeyName: String) -> Observable<T> {
        print("DatabaseProviderMock.observableObject called")
        return .empty()
    }

    func observableCollection<T: Object>(_ type: T.Type, predicate: NSPredicate?, sortBy: String?, ascending: Bool) -> Observable<[T]> {
        print("DatabaseProviderMock.observableCollection called")
        return .empty()
    }

    func deleteAll() {
        print("DatabaseProviderMock.deleteAll called")
    }
}
