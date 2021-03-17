//
//  KotlinUseCase+Extensions.swift
//  DomainLayer
//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DevstackKmpShared
import Foundation
import RxSwift

extension DevstackKmpShared.GetUserUseCase {
    func asObservable(_ userId: String) -> Observable<User> {
        return createObservable(
            self, DevstackKmpShared.GetUserUseCase.Params(userId: userId)) { kotlinUser in
                kotlinUser.toSwiftUser()
        }
    }
}

extension DevstackKmpShared.GetDummyFlowUseCase {
    func asObservable() -> Observable<String> {
        return createObservable(self) { kotlinDomain in
            String(kotlinDomain)
        }
    }
}

// All usecases runs on Dispatcher.Default and it means that every async operation is executed by system backround thread - in case of ios it should be an IO thread

// Create observable from suspendable usecase with params
// Invoke usecase and complete
func createObservable<Params, KotlinDomain, SwiftDomain>(
    _ usecase: UseCaseResult<Params, KotlinDomain>,
    _ params: Params,
    _ transform:@escaping (KotlinDomain) -> SwiftDomain ) -> Observable<SwiftDomain> {
    
    return Observable<SwiftDomain>.create { observer in
        let job: Kotlinx_coroutines_coreJob = usecase.subscribe(params: params) { result in
            if let success = result as? ResultSuccess {
                observer.on(.next(transform(success.data as! KotlinDomain))) // swiftlint:disable:this force_cast
                observer.onCompleted()
            } else if let errorResult = result as? ResultError {
                observer.on(.error(errorResult.error.toSwiftError()))
            }
        } onThrow_: { kotlinThrowable in
            observer.on(.error(KotlinThrowableError(kotlinThrowable)))
        }
        return Disposables.create { job.cancel(cause: nil) }
    }
}

// Create observable from usecase with params that retuns flow
// Invoke usecase and collect all values from flow. When flow ends than observable stream ends
func createObservable<Params, KotlinDomain, SwiftDomain>(
    _ usecase: UseCaseFlowResult<Params, KotlinDomain>,
    _ params: Params,
    _ transform:@escaping (KotlinDomain) -> SwiftDomain ) -> Observable<SwiftDomain> {
    
    return Observable<SwiftDomain>.create { observer in
        let job: Kotlinx_coroutines_coreJob = usecase.subscribe(params: params) { result in
            if let success = result as? ResultSuccess {
                observer.on(.next(transform(success.data as! KotlinDomain))) // swiftlint:disable:this force_cast
            } else if let errorResult = result as? ResultError {
                observer.on(.error(errorResult.error.toSwiftError()))
            }
        } onComplete: {
            observer.on(.completed)
        } onThrow: { kotlinThrowable in
            observer.on(.error(KotlinThrowableError(kotlinThrowable)))
        }
        return Disposables.create { job.cancel(cause: nil) }
    }
}

// Create observable from suspendable usecase without
// Invoke usecase and complete
func createObservable<KotlinDomain, SwiftDomain>(
    _ usecase: UseCaseResultNoParams<KotlinDomain>,
    _ transform:@escaping (KotlinDomain) -> SwiftDomain ) -> Observable<SwiftDomain> {
    
    return Observable<SwiftDomain>.create { observer in
        let job: Kotlinx_coroutines_coreJob = usecase.subscribe { result in
            if let success = result as? ResultSuccess {
                observer.on(.next(transform(success.data as! KotlinDomain))) // swiftlint:disable:this force_cast
                observer.onCompleted()
            } else if let errorResult = result as? ResultError {
                observer.on(.error(errorResult.error.toSwiftError()))
            }
        } onThrow: { kotlinThrowable in
            observer.on(.error(KotlinThrowableError(kotlinThrowable)))
        }
        return Disposables.create { job.cancel(cause: nil) }
    }
}

// Create observable from usecase without params that retuns flow
// Invoke usecase and collect all values from flow. When flow ends than observable stream ends
func createObservable<KotlinDomain, SwiftDomain>(
    _ usecase: UseCaseFlowResultNoParams<KotlinDomain>,
    _ transform:@escaping (KotlinDomain) -> SwiftDomain ) -> Observable<SwiftDomain> {
    
    return Observable<SwiftDomain>.create { observer in
        let job: Kotlinx_coroutines_coreJob = usecase.subscribe { result in
            if let success = result as? ResultSuccess {
                observer.on(.next(transform(success.data as! KotlinDomain))) // swiftlint:disable:this force_cast
            } else if let errorResult = result as? ResultError {
                observer.on(.error(errorResult.error.toSwiftError()))
            }
        } onComplete: {
            observer.on(.completed)
        } onThrow: { kotlinThrowable in
            observer.on(.error(KotlinThrowableError(kotlinThrowable)))
        }
        return Disposables.create { job.cancel(cause: nil) }
    }
}

// Create observable from usecase that returns unit -> void
// Invoke usecase and complete
func createObservable<Params>(
    _ usecase: UseCaseResult<Params, KotlinUnit>,
    _ params: Params) -> Observable<Event<Void>> {
    
    return Observable<Void>.create { observer in
        let job: Kotlinx_coroutines_coreJob = usecase.subscribe(params: params) { result in
            switch result {
            case is ResultSuccess<AnyObject>:
                    observer.on(.next(()))
                    observer.onCompleted()
            case let errorResult as ResultError<AnyObject> :
                    observer.on(.error(errorResult.error.toSwiftError()))
            default:
                observer.on(.error(UnknownKotlinError()))
            }
        } onThrow_: { kotlinThrowable in
            observer.on(.error(KotlinThrowableError(kotlinThrowable)))
        }
        return Disposables.create { job.cancel(cause: nil) }
    }.mapToVoid().materialize()
}

// Create observable from usecase without params that retuns flow
// Invoke usecase and collect all values from flow. When flow ends than observable stream ends
func createObservable<KotlinDomain, SwiftDomain>(
    _ usecase: UseCaseFlowNoParams<KotlinDomain>,
    _ transform:@escaping (KotlinDomain) -> SwiftDomain ) -> Observable<SwiftDomain> {
    
    return Observable<SwiftDomain>.create { observer in
        let job: Kotlinx_coroutines_coreJob = usecase.subscribe { item in
            observer.on(.next(transform(item as! KotlinDomain))) // swiftlint:disable:this force_cast
        } onComplete: {
            observer.on(.completed)
        } onThrow: { kotlinThrowable in
            observer.on(.error(KotlinThrowableError(kotlinThrowable)))
        }
        return Disposables.create { job.cancel(cause: nil) }
    }
}

extension DevstackKmpShared.ErrorResult {
    func toSwiftError() -> LocalizedError {
        return CommonError.noAuthToken
    }
}

class UnknownKotlinError: LocalizedError {}

class KotlinThrowableError: LocalizedError {
    let throwable: KotlinThrowable
    
    init(_ throwable: KotlinThrowable) {
        self.throwable = throwable
    }
    
    var errorDescription: String? {
        get { throwable.message }
    }
}
