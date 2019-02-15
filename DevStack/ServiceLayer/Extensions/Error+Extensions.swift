//
//  Error+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RxSwift
import os.log

extension Error {
    
    func asServiceError<T: Any>() -> Observable<Lce<T>> {
        if let serviceError = self as? ServiceError {
            return Observable.just(Lce(error: serviceError))
        } else {
            os_log("Error can't be converted to ServiceError:\n%@", log: Logger.appLog(), type: .error, "\(self)")
            return Observable.error(self)
        }
    }
}
