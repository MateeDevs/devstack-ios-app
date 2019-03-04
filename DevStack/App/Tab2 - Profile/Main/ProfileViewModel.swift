// 
//  ProfileViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/03/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import RxSwift
import RxCocoa

final class ProfileViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasLoginService
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
    }
    
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    func logout() {
        dependencies.loginService.logout()
    }
}
