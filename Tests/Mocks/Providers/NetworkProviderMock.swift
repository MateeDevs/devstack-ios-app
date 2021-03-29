//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Moya
import RxSwift

enum ResponseType: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case internalServerError = 500
}

class NetworkProviderMock {
    
    var observableRequestCallsCount = 0

    private weak var _delegate: NetworkProviderDelegate?
    private let stubbingProvider: MoyaProvider<MultiTarget>

    init(response: ResponseType = .success) {
        stubbingProvider = MoyaProvider<MultiTarget>(
            endpointClosure: { (target: MultiTarget) -> Endpoint in
                Endpoint(
                    url: URL(target: target).absoluteString,
                    sampleResponseClosure: {
                        .networkResponse(response.rawValue, response == .success ? target.sampleData : Data())
                    },
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
        observableRequestCallsCount += 1
        return stubbingProvider.rx.request(MultiTarget(endpoint))
            .asObservable().filterSuccessfulStatusCodes()
            .catchError { error -> Observable<Response> in
                guard let moyaError = error as? MoyaError,
                      let response = moyaError.response,
                      let statusCode = StatusCode(rawValue: response.statusCode) else { return .error(error) }
                return .error(RepositoryError(statusCode: statusCode, message: response.description))
            }
    }
}
