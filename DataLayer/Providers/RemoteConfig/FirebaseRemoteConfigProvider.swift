//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import FirebaseRemoteConfig
import RxSwift

public struct FirebaseRemoteConfigProvider {
    
    public init() {
        // Set fetch interval to zero for non production environments
        if Environment.value.type != .production {
            let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 0
            RemoteConfig.remoteConfig().configSettings = settings
        }
    }
}

extension FirebaseRemoteConfigProvider: RemoteConfigProviderType {
    
    public func get(_ key: RemoteConfigCoding) -> Observable<Bool> {
        return RemoteConfig.remoteConfig().rx.fetch().flatMap { _ -> Observable<Bool> in
             let boolValue = RemoteConfig.remoteConfig().configValue(forKey: key.rawValue).boolValue
             return Observable.just(boolValue)
        }
    }
}
