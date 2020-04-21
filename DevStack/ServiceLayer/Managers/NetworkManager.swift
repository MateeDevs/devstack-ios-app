//
//  Network.swift
//  DevStack
//
//  Created by Petr Chmelar on 14/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Moya
import RxSwift

struct NetworkManager {
    
    private let provider = AuthenticatedProvider<MultiTarget>()
    
    ///
    /// Function for observing on a specified network call.
    /// Automatically filters out API errors.
    ///
    /// - parameter endpoint: TargetType from Moya which specify API endpoint to be called.
    /// - parameter withInterceptor: Specify whether build-in interceptor should be enabled.
    /// - returns: Observable which emits Response of a network call.
    ///
    func observableRequest(_ endpoint: TargetType, withInterceptor: Bool = true) -> Observable<Response> {
        provider.request(MultiTarget(endpoint), withInterceptor: withInterceptor).asObservable().filterSuccessfulStatusCodes()
    }
}
