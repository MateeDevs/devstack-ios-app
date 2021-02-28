//
//  Created by Petr Chmelar on 26.02.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public enum EnvironmentType {
    case alpha
    case beta
    case production
}

public struct Environment {
    let type: EnvironmentType
    
    public init(type: EnvironmentType) {
        self.type = type
    }
}

public struct DataEnvironment {
    @InitializedOnlyOnce public static var environment: Environment! // swiftlint:disable:this implicitly_unwrapped_optional
}

@propertyWrapper
public class InitializedOnlyOnce<Value> {
    public init() {}

    public var wrappedValue: Value? {
        didSet {
            assert(oldValue == nil, "Not allowed to re-assign value when using @InitializedOnlyOnce!")
        }
    }
}
