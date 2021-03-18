//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol HasGetProfileIdUseCase {
    var getProfileIdUseCase: GetProfileIdUseCaseType { get }
}

public protocol GetProfileIdUseCaseType: AutoMockable {
    func execute() -> String?
}

public struct GetProfileIdUseCase: GetProfileIdUseCaseType {
    
    public typealias Dependencies =
        HasAuthTokenRepository &
        HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() -> String? {
        dependencies.authTokenRepository.read()?.userId
    }
}
