//
//  Environment.swift
//  DevStack
//
//  Created by Petr Chmelar on 25.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import UIKit

enum EnvironmentType {
    case alpha
    case beta
    case production
}

struct Environment {
    let type: EnvironmentType
}

extension UIApplication {
    @InitializedOnlyOnce static var environment: Environment! // swiftlint:disable:this implicitly_unwrapped_optional
}

@propertyWrapper
class InitializedOnlyOnce<Value> {
    init() {}

    var wrappedValue: Value? {
        didSet {
            assert(oldValue == nil, "Not allowed to re-assign value when using @InitializedOnlyOnce!")
        }
    }
}
