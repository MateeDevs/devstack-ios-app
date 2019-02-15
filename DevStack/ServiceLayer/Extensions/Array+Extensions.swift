//
//  Array+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 17/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RealmSwift

extension Array where Element: RealmCollectionValue {
    
    public func toList() -> List<Element> {
        let list = List<Element>()
        list.append(objectsIn: self)
        return list
    }
}
