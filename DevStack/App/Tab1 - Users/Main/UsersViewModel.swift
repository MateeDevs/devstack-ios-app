// 
//  UsersViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import RxSwift
import RxCocoa

final class UsersViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasNoService
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
