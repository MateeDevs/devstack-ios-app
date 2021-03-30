//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation

@testable import DataLayer

// swiftlint:disable force_try

extension DomainRepresentable where Self: Decodable {
    static var stubDomain: Self.DomainModel {
        let object = try! JSONDecoder().decode(self, from: stub)
        return object.domainModel
    }
    
    static func stubListDomain(atKeyPath keyPath: String? = nil) -> [Self.DomainModel] where Self: Any {
        var data = stubList
        
        if let keyPath = keyPath,
           let dict = try! JSONSerialization.jsonObject(with: stubList, options: .allowFragments) as? NSDictionary,
           let jsonObject = dict.value(forKey: keyPath) {
            data = try! JSONSerialization.data(withJSONObject: jsonObject)
        }
        
        let objects = try! JSONDecoder().decode([Self].self, from: data)
        return objects.map { $0.domainModel }
    }
}
