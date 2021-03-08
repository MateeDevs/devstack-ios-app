//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasLogoutUseCase {
    var logoutUseCase: LogoutUseCase { get }
}

public struct LogoutUseCase {
    
    public typealias Dependencies = HasAuthTokenRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func execute() -> Observable<Event<Void>> {
        dependencies.authTokenRepository.delete().materialize()
    }
}
