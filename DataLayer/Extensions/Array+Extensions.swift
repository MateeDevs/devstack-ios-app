//
//  Created by Petr Chmelar on 17/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import RealmSwift

public extension Array where Element: RealmCollectionValue {
    func toList() -> List<Element> {
        let list = List<Element>()
        list.append(objectsIn: self)
        return list
    }
}
