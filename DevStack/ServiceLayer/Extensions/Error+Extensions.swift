//
//  Error+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension Error {

    func asLceError<T: Any>(_ errors: LceErrors? = nil) -> Observable<Lce<T>> {
        Logger.error("%@", localizedDescription, category: .app)

        if let netError = self as? MoyaError, let statusCode = netError.response?.statusCode, let message = errors?.messages[statusCode] {
            return Observable.just(Lce(error: ServiceError(statusCode: statusCode, message: message)))
        } else {
            return Observable.just(Lce(error: ServiceError(statusCode: StatusCode.networkError, message: errors?.defaultMessage)))
        }
    }

}
