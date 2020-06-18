//
//  UsersViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

final class UsersViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasUserService

    let input: Input
    let output: Output
    
    struct Input {
        let page: AnyObserver<Int>
    }
    
    struct Output {
        let getUsers: Driver<[User]>
        let downloadUsers: Driver<Lce<[User]>>
    }
    
    init(dependencies: Dependencies) {
        let page = PublishSubject<Int>()
        
        let getUsers: Driver<[User]> = dependencies.userService.getUsers().asDriverOnErrorJustComplete()
        
        let downloadUsers = page.flatMap({ page -> Observable<Lce<[User]>> in
            dependencies.userService.downloadUsersForPage(page).mapToLce()
        }).asDriverOnErrorJustComplete()
        
        self.input = Input(
            page: page.asObserver()
        )
        
        self.output = Output(
            getUsers: getUsers,
            downloadUsers: downloadUsers
        )
        
        super.init()
    }
}
