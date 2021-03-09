//
//  Created by Petr Chmelar on 14/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Moya
import RxSwift

public protocol HasNetworkProvider {
    var networkProvider: NetworkProviderType { get }
}

public protocol NetworkProviderType {

    ///
    /// Function for observing on a specified network call.
    /// Automatically filters out API errors.
    ///
    /// - parameter endpoint: TargetType from Moya which specify API endpoint to be called.
    /// - parameter withInterceptor: Optional parameter to specify whether build-in interceptor should be enabled.
    /// - returns: Observable which emits Response of a network call.
    ///
    func observableRequest(_ endpoint: TargetType, withInterceptor: Bool) -> Observable<Response>
}

// This extension exists only to provide default values for option parameters
extension NetworkProviderType {
    func observableRequest(_ endpoint: TargetType, withInterceptor: Bool = true) -> Observable<Response> {
        observableRequest(endpoint, withInterceptor: withInterceptor)
    }
}

public struct NetworkProvider: NetworkProviderType {

    private let moyaProvider: AuthenticatedProvider<MultiTarget>

    public init(keychainProvider: KeychainProviderType, databaseProvider: DatabaseProviderType) {
        self.moyaProvider = AuthenticatedProvider<MultiTarget>(
            keychainProvider: keychainProvider,
            databaseProvider: databaseProvider
        )
    }

    public func observableRequest(_ endpoint: TargetType, withInterceptor: Bool) -> Observable<Response> {
        moyaProvider.request(MultiTarget(endpoint), withInterceptor: withInterceptor)
            .asObservable().filterSuccessfulStatusCodes()
            .catchError { error -> Observable<Response> in
                guard let moyaError = error as? MoyaError,
                      let response = moyaError.response,
                      let statusCode = StatusCode(rawValue: response.statusCode) else { return .error(error) }
                return .error(RepositoryError(statusCode: statusCode, message: response.description))
            }
    }
}
