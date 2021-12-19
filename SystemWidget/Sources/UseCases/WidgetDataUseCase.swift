//
//  Created by Tomas Brand on 05.12.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import Foundation
import RxSwift

public protocol WidgetDataUseCaseProtocol {
    func execute(id: String) -> Observable<User>
}

public struct WidgetDataUseCaseImpl: WidgetDataUseCaseProtocol {
   
    public typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(id: String) -> Observable<User> {
        dependencies.userRepository.read(.local, id: id)
    }
}
