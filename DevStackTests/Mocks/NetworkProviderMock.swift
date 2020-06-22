//
//  NetworkProviderMock.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Moya
import RxSwift

@testable import A_DevStack

enum ResponseType: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case internalServerError = 500
}

class NetworkProviderMock: NetworkProviderType {

    var firedRequests = 0

    private let stubbingProvider: MoyaProvider<MultiTarget>

    init(response: ResponseType = .success) {
        stubbingProvider = MoyaProvider<MultiTarget>(
            endpointClosure: { (target: MultiTarget) -> Endpoint in
                return Endpoint(
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

    func observableRequest(_ endpoint: TargetType, withInterceptor: Bool) -> Observable<Response> {
        firedRequests += 1
        return stubbingProvider.rx.request(MultiTarget(endpoint)).asObservable().filterSuccessfulStatusCodes()
    }
}
