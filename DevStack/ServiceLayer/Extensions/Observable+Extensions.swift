//
//  Observable+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 26/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    
    public func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToLce<T: Any>(_ errors: LceErrors? = nil) -> Observable<Lce<T>> where E == T {
        return flatMap({ object -> Observable<Lce<T>> in
            return Observable.just(Lce<T>(data: object))
        }).catchError({ error in
            error.asLceError(errors)
        }).startWith(Lce(loading: true))
    }
    
    func mapToLce<T: Any>(_ errors: LceErrors? = nil) -> Observable<Lce<[T]>> where E == [T] {
        return flatMap({ objects -> Observable<Lce<[T]>> in
            return Observable.just(Lce<[T]>(data: objects))
        }).catchError({ error in
            error.asLceError(errors)
        }).startWith(Lce(loading: true))
    }
    
    func mapToLceVoid(_ errors: LceErrors? = nil) -> Observable<Lce<Void>> {
        return map { _ in
            return Lce(data: Void())
        }.catchError({ error in
            error.asLceError(errors)
        }).startWith(Lce(loading: true))
    }
    
}
