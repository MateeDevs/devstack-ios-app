//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasRemoteConfigProvider {
    var remoteConfigProvider: RemoteConfigProviderType { get }
}

public protocol RemoteConfigProviderType {
    /// Try to retrieve a value for the given key
    func get(_ key: RemoteConfigCoding) -> Observable<Bool>
}
