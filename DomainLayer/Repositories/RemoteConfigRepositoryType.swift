//
//  Created by Petr Chmelar on 08.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasRemoteConfigRepository {
    var remoteConfigRepository: RemoteConfigRepositoryType { get }
}

public protocol RemoteConfigRepositoryType: AutoMockable {
    func read(_ key: RemoteConfigCoding) -> Observable<Bool>
}
