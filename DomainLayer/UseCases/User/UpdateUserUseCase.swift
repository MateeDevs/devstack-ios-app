//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasUpdateUserUseCase {
    var updateUserUseCase: UpdateUserUseCaseType { get }
}

public protocol UpdateUserUseCaseType: AutoMockable {
    func execute(user: User) -> Observable<Void>
}

public struct UpdateUserUseCase: UpdateUserUseCaseType {
    
    public typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(user: User) -> Observable<Void> {
        dependencies.userRepository.update(.remote, user: user).mapToVoid()
    }
}
