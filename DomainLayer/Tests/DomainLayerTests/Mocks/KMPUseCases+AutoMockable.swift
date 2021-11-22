//
//  Created by Petr Chmelar on 17.05.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DevstackKmpShared
import DomainLayer

typealias MockableGetBooksUseCase = GetBooksUseCase & AutoMockable
typealias MockableRefreshBooksUseCase = RefreshBooksUseCase & AutoMockable

/// SwiftyMocky does not work with protocol composition right now
/// Therefore we have to provide KMPUseCaseMocks manually
/// [Related PR](https://github.com/MakeAWishFoundation/SwiftyMocky/pull/280)

#warning("Delete these classes after SwiftyMocky support protocol composition")

// class GetBooksUseCaseMock: GetBooksUseCase {
//    func invoke(completionHandler: @escaping (Kotlinx_coroutines_coreFlow?, Error?) -> Void) {}
//    func invoke(params: Any?, completionHandler_ completionHandler: @escaping (Any?, Error?) -> Void) {}
// }
//
// class RefreshBooksUseCaseMock: RefreshBooksUseCase {
//    func invoke(completionHandler: @escaping (Result<AnyObject>?, Error?) -> Void) {}
// }
