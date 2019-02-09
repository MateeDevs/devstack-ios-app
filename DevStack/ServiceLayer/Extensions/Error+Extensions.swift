//
//  Error+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RxSwift

extension Error {
    func asServiceError<T: Any>() -> Observable<Lce<T>> {
        if let serviceError = self as? ServiceError {
            return Observable.just(Lce(error: serviceError))
        } else {
            print(self)
            return Observable.error(self)
        }
    }
}
