//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension ObservableType where Self.Element == Moya.Response {
    
    /// Wrapper around Moya's map, returns domain representation of saved network model
    func map<D>(
        _ type: D.Type,
        atKeyPath keyPath: String? = nil,
        using decoder: JSONDecoder = JSONDecoder(),
        failsOnEmptyData: Bool = true
    ) -> RxSwift.Observable<D.DomainModel> where D: Decodable & DomainRepresentable {
        return map(type, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData).map { $0.domainModel }
    }
    
    /// Wrapper around Moya's map, returns domain representations of saved network models
    func map<D>(
        _ type: [D].Type,
        atKeyPath keyPath: String? = nil,
        using decoder: JSONDecoder = JSONDecoder(),
        failsOnEmptyData: Bool = true
    ) -> RxSwift.Observable<[D.DomainModel]> where D: Decodable & DomainRepresentable {
        return map(type, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData).map { $0.map { $0.domainModel } }
    }
}
