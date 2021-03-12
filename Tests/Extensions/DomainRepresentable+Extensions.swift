//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DataLayer

extension DomainRepresentable where Self: Decodable {
    static var stubDomain: Self.DomainModel {
        try! JSONDecoder().decode(self, from: self.stub).domainModel // swiftlint:disable:this force_try
    }
}
