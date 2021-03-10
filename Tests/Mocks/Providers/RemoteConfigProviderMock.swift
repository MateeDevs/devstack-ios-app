//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

class RemoteConfigProviderMock: RemoteConfigProviderType {

    func get(_ key: RemoteConfigCoding) -> Observable<Bool> {
        print("RemoteConfigProviderMock.get called")
        return .empty()
    }
}
