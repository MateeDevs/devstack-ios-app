//
//  Object+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import RxSwift

extension Object {
    
    /// Model for partial updates of Realm objects (to prevent overwriting optional existing attributes).
    /// - Just override apiModel() function in your object's class and remove properties you don't want to be updated
    /// - Idea taken from [GitHub Realm Issue #4882](https://github.com/realm/realm-cocoa/issues/4882#issuecomment-295613895)
    /// - Doesn't work for nested objects :(
    @objc func fullModel() -> [String: Any] {
        var model: [String: Any] = [:]
        let schema = RLMSchema.partialShared().schema(forClassName: String(describing: type(of: self).self))
        if let schema = schema {
            for property in schema.properties {
                model[property.name] = value(forKey: property.name)
            }
        }
        return model
    }
    
    @objc func apiModel() -> [String : Any] {
        return fullModel()
    }
    
    func exists() -> Bool {
        guard let id = value(forKey: "id") else { return false }
        let realm = try! Realm()
        return realm.object(ofType: type(of: self).self, forPrimaryKey: id) != nil
    }
}
