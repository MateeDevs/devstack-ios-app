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
        let refreshTrigger: AnyObserver<Void>
    }
    
    struct Output {
        let getUser: Driver<User>
        let downloadUser: Driver<Lce<User>>
    }
    
    init(dependencies: Dependencies, userId: String) {
        self.userId = userId
        
        let refreshTrigger = PublishSubject<Void>()
        
        let getUser: Driver<User> = dependencies.userService.getUserById(userId).asDriverOnErrorJustComplete()
        
        let downloadUser = refreshTrigger.flatMap({ _ -> Observable<Lce<User>> in
            dependencies.userService.downloadUserById(userId)
        }).asDriverOnErrorJustComplete()
        
        self.input = Input(refreshTrigger: refreshTrigger.asObserver())
        self.output = Output(getUser: getUser, downloadUser: downloadUser)
        
        super.init()
    }
}
