//
//  Error+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RxSwift

extension Error {
    
    func asLceError<T: Any>(_ errors: LceErrors? = nil) -> Observable<Lce<T>> {
        
        Logger.error("%@", localizedDescription, category: .app)
        
        guard let serviceError = self as? ServiceError else { return Observable.error(self) }
        
        if let message = errors?.messages[serviceError.statusCode] {
            return Observable.just(Lce(error: ServiceError(statusCode: serviceError.statusCode, message: message)))
        } else {
            return Observable.just(Lce(error: ServiceError(statusCode: serviceError.statusCode, message: errors?.defaultMessage)))
        }
    }
}
