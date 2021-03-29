//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DevstackKmpShared

public protocol HasBookUseCases {
    var getBooksUseCase: GetBooksUseCase { get }
    var refreshBooksUseCase: RefreshBooksUseCase { get }
}
