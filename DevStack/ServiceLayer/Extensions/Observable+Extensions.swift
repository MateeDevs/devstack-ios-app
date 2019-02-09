//
//  Observable+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 26/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    
    func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    func mapToLceVoid() -> Observable<Lce<Void>> {
        return map { _ in
            return Lce(data: Void())
        }
    }
}
