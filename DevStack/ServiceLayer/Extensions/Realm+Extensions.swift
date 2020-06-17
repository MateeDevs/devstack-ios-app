//
//  Realm+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 17/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

// Idea taken from: https://stackoverflow.com/a/56218423

import RealmSwift

extension Realm {
    static func safeInit() -> Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch {
            Logger.error("Error during Realm init:\n%@", "\(error)", category: .app)
        }
        return nil
    }

    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
