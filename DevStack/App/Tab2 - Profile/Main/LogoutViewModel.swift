// 
//  LogoutViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 04/03/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import RxSwift
import RxCocoa

final class LogoutViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasLoginService
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
    }
    
    struct Input {
        let logoutButtonTaps: Signal<()>
    }
    
    struct Output {
        let logoutEvent: Driver<Lce<Void>>
    }
    
    func transform(input: Input) -> Output {
        
        let logoutEvent = input.logoutButtonTaps.flatMap { _ -> Driver<Lce<Void>> in
            return self.dependencies.loginService.logout().asDriverOnErrorJustComplete()
        }
        
        return Output(logoutEvent: logoutEvent)
    }
}
