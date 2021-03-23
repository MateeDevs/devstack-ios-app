//
//  Created by Petr Chmelar on 23.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation

@testable import DataLayer

extension NETUser {
    static var stubListDomain: [Self.DomainModel] {
        stubListDomain(atKeyPath: "data")
    }
}
