//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DevstackKmpShared
import DomainLayer
import Foundation

public protocol KMPDependency {
    func get<T: AnyObject>(_ type: T.Type) -> T
}

public class KmpKoinDependency: KMPDependency {
    
    private var _koin: Koin_coreKoin?
    
    public init() {
        startKoin()
    }
    
    private func startKoin() {
        let onStartup = {
            DomainLayer.Logger.debug("Koin Started", category: .app)
        }
        
        let koinApplication = KoinIOSKt.doInitKoinIos(doOnStartup: onStartup)
        _koin = koinApplication.koin
    }
    
    public func get<T: AnyObject>(_ type: T.Type) -> T {
        _koin?.get(objCClass: type) as! T // swiftlint:disable:this force_cast
    }
}
