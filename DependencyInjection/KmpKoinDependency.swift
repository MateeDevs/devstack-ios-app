//
//  KmpKoinDependency.swift
//  DependencyInjection
//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DevstackKmpShared
import Foundation

public class KmpKoinDependency {
    
    private var _koin: Koin_coreKoin?
    
    var koin: Koin_coreKoin {
        return _koin!
    }
    
    public init() {
        startKoin()
    }
    
    private func startKoin() {
        let onStartup = { NSLog( "Koin initialized") }
        
        let koinApplication = KoinIOSKt.doInitKoinIos(doOnStartup: onStartup)
        _koin = koinApplication.koin
    }
    
    public func get<T: AnyObject>(_ type: T.Type) -> T {
        koin.get(objCClass: type) as! T // swiftlint:disable:this force_cast
    }
}

enum KoinDiError: Swift.Error {
    case invalidCast
}

public protocol HasKmpSharedUseCases {
    var kmpGetUserUseCase: DevstackKmpShared.GetUserUseCase { get }
    var kmpLoginUser: DevstackKmpShared.LoginUseCase { get }
    var kmpGetUsersUsecase: DevstackKmpShared.GetUsersUseCase { get }
    var kmpGetDummyUsecase: DevstackKmpShared.GetDummyFlowUseCase { get }
}
