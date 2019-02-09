//
//  Moya+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 26/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension ObservableType where E == Response {
    
    // Transformation for filtering out successful status codes (same as default filterSuccessfulStatusCodes)
    // Additionaly provides conversion from MoyaError to ServiceError
    // Idea taken from: https://stackoverflow.com/questions/39185109/custom-error-response-handling-with-moya-rxswift
    func filterSuccess() -> Observable<E> {
        return flatMap { (response) -> Observable<E> in
            
            if 200 ... 299 ~= response.statusCode {
                return Observable.just(response)
            }
            
            if let error = try? response.map(ServiceError.self) {
                error.statusCode = response.statusCode
                return Observable.error(error)
            }
            
            let genericError = ServiceError(statusCode: response.statusCode)
            return Observable.error(genericError)
        }
    }
}
