//
//  Network.swift
//  DevStack
//
//  Created by Petr Chmelar on 14/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import Foundation
import Moya
import RxSwift

struct NetworkManager {
    
    private let provider = AuthenticatedProvider<MultiTarget>()
    
    ///
    /// Function for observing on a specified network call.
    /// Automatically filters out API errors.
    ///
    /// - parameter endpoint: TargetType from Moya which specify API endpoint to be called.
    /// - returns: Observable which emits Response of a network call.
    ///
    func observableRequest(_ endpoint: TargetType) -> Observable<Response> {
        return provider.request(MultiTarget(endpoint)).asObservable().filterSuccess()
    }
}
