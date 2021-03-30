//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DataLayer
import Foundation
import Moya
import RxSwift

class NetworkProviderMock {
    
    var observableRequestCallsCount = 0
    var observableRequestReturnError: Error?

    private weak var _delegate: NetworkProviderDelegate?
    private let stubbingProvider: MoyaProvider<MultiTarget>

    init() {
        stubbingProvider = MoyaProvider<MultiTarget>(
            endpointClosure: { (target: MultiTarget) -> Endpoint in
                Endpoint(
                    url: URL(target: target).absoluteString,
                    sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            },
            stubClosure: MoyaProvider.immediatelyStub
        )
    }
}

extension NetworkProviderMock: NetworkProvider {
    
    var delegate: NetworkProviderDelegate? {
        get {
            _delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    func observableRequest(_ endpoint: TargetType, withInterceptor: Bool) -> Observable<Response> {
        if let error = observableRequestReturnError {
            return Observable.error(error).do(onError: { _ in self.observableRequestCallsCount += 1 })
        } else {
            return stubbingProvider.rx.request(MultiTarget(endpoint)).asObservable().do { _ in self.observableRequestCallsCount += 1 }
        }
    }
}
