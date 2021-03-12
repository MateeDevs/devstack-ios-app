//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

class RemoteConfigProviderMock {
    
    var storage: [RemoteConfigCoding: Bool] = [:]

    init(_ storage: [RemoteConfigCoding: Bool] = [:]) {
        self.storage = storage
    }
}

extension RemoteConfigProviderMock: RemoteConfigProviderType {

    func get(_ key: RemoteConfigCoding) -> Observable<Bool> {
        providerEvents.append(.remoteConfigGet(key))
        guard let value = storage[key] else { return .empty() }
        return .just(value)
    }
}
