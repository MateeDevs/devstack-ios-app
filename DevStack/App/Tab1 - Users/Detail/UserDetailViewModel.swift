// 
//  UserDetailViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import RxCocoa

final class UserDetailViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasUserService
    
    private var userId: String
    
    let input: Input
    let output: Output
    
    struct Input {
    }
    
    struct Output {
        let getUserDetailEvent: Driver<Lce<User>>
    }
    
    init(dependencies: Dependencies, userId: String) {
        self.userId = userId
        
        let getUserDetailEvent: Driver<Lce<User>> = dependencies.userService.getUserById(userId).asDriverOnErrorJustComplete()
        
        self.input = Input()
        self.output = Output(getUserDetailEvent: getUserDetailEvent)
        
        super.init()
    }
}
