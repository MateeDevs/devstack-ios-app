//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import FirebaseRemoteConfig
import RxSwift
import UIKit

public protocol HasRemoteConfigProvider {
    var remoteConfigProvider: RemoteConfigProviderType { get }
}

public protocol RemoteConfigProviderType {
    /// Try to retrieve a value for the given key
    func get(_ key: RemoteConfigCoding) -> Observable<Bool>
}

public struct RemoteConfigProvider: RemoteConfigProviderType {
    
    public init() {
        // Set fetch interval to zero for non production environments
        if Environment.value.type != .production {
            let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 0
            RemoteConfig.remoteConfig().configSettings = settings
        }
    }
    
    public func get(_ key: RemoteConfigCoding) -> Observable<Bool> {
        return RemoteConfig.remoteConfig().rx.fetch().flatMap { _ -> Observable<Bool> in
             let boolValue = RemoteConfig.remoteConfig().configValue(forKey: key.rawValue).boolValue
             return Observable.just(boolValue)
        }
    }
}
