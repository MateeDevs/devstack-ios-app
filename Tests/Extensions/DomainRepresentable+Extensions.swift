//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DataLayer

extension DomainRepresentable where Self: Decodable {
    static var stubDomain: Self.DomainModel {
        try! JSONDecoder().decode(self, from: stub).domainModel // swiftlint:disable:this force_try
    }
    
    static var stubListDomain: [Self.DomainModel] {
        try! JSONDecoder().decode([Self].self, from: stubList).map { $0.domainModel } // swiftlint:disable:this force_try
    }
}
