//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol HasGetProfileIdUseCase {
    var getProfileIdUseCase: GetProfileIdUseCase { get }
}

public struct GetProfileIdUseCase {
    
    public typealias Dependencies =
        HasAuthTokenRepository &
        HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func execute() -> String? {
        dependencies.authTokenRepository.read()?.userId
    }
}
