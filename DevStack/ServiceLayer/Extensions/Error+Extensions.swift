//
//  Error+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension Error {
    
    func asServiceError<T: Any>(_ messages: ErrorMessages? = nil) -> Observable<Lce<T>> {
        Logger.error("%@", localizedDescription, category: .app)
        
        if let netError = self as? MoyaError, let code = netError.response?.statusCode, let message = messages?.statusCodes[code] {
            return Observable.just(.error(ServiceError(statusCode: code, message: message)))
        } else {
            return Observable.just(.error(ServiceError(statusCode: StatusCode.networkError, message: messages?.defaultMessage)))
        }
    }
    
}
