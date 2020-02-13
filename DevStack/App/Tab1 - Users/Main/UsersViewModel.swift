// 
//  UsersViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import RxCocoa

final class UsersViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasUserService

    let input: Input
    let output: Output
    
    struct Input {
        let page: AnyObserver<Int>
    }
    
    struct Output {
        let getUsersEvent: Driver<Lce<[User]>>
        let downloadUsersEvent: Driver<Lce<[User]>>
    }
    
    init(dependencies: Dependencies) {
        let page = PublishSubject<Int>()
        
        let getUsersEvent: Driver<Lce<[User]>> = dependencies.userService.getUsers().asDriverOnErrorJustComplete()
        
        let downloadUsersEvent = page.flatMap({ (page) -> Observable<Lce<[User]>> in
            dependencies.userService.downloadUsersForPage(page)
        }).asDriverOnErrorJustComplete()
        
        self.input = Input(page: page.asObserver())
        self.output = Output(getUsersEvent: getUsersEvent, downloadUsersEvent: downloadUsersEvent)
        
        super.init()
    }
}
