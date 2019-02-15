//
//  PreviewObject.swift
//  DevStack
//
//  Created by Petr Chmelar on 05/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

// Wrapper around Realm Object to handle previews of objects coming from API
// Just decode to your preview object during decoding phase
// Then call createFullObject() to obtain full object updated with values from preview object

class PreviewObject: Object {
    
    func createFullObject<T: Object>() -> T {
        
        // Create a new empty instance of full object
        var object = T()
        
        // Try to populate with values from db
        let realm = try! Realm()
        if let id = self.value(forKey: "id"), let dbObject = realm.object(ofType: T.self, forPrimaryKey: id) {
            // Cannot use init(value: ...)
            // Related issue: https://github.com/realm/realm-cocoa/issues/5714
            object = T(value: dbObject, schema: .partialPrivateShared())
        }
        
        // Update with values from preview object
        let schema = RLMSchema.partialShared().schema(forClassName: String(describing: type(of: self).self))
        if let schema = schema {
            for property in schema.properties {
                object.setValue(self.value(forKey: property.name), forKey: property.name)
            }
        }
        
        return object
    }
    
}
