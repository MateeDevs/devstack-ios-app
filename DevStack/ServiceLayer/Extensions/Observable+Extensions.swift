//
//  Observable+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 26/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { _ in
            Driver.empty()
        }
    }
    
    func mapToLce<T: Any>(_ messages: ErrorMessages? = nil) -> Observable<Lce<T>> where Element == T {
        return flatMap({ object -> Observable<Lce<T>> in
            Observable.just(.content(object))
        }).catchError({ error in
            error.asServiceError(messages)
        }).startWith(.loading)
    }
    
    func mapToLceVoid(_ messages: ErrorMessages? = nil) -> Observable<Lce<Void>> {
        return map { _ in
            .content(Void())
        }.catchError({ error in
            error.asServiceError(messages)
        }).startWith(.loading)
    }
    
    func filterErrors<T: Any>() -> Observable<Lce<T>> where Element == Lce<T> {
        return filter { (lce) -> Bool in
            if case .error = lce {
                return true
            } else {
                return false
            }
        }
    }
    
}
