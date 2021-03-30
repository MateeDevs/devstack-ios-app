//
//  Created by Petr Chmelar on 09.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import Foundation

/// Main setup shared by all XCTestCases
/// Idea taken from [StackOverflow](https://stackoverflow.com/a/41895011)
class Tests: NSObject {
    override init() {
        Environment.value = EnvironmentValue(type: .alpha)
    }
}
