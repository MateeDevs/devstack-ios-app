// 
//  UsersViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import RxSwift
import RxCocoa

final class UsersViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasUserService
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    struct Input {
        let page: PublishSubject<Int>
    }
    
    struct Output {
        let getUsersEvent: Driver<Lce<[User]>>
        let downloadUsersEvent: Driver<Lce<[User]>>
    }
    
    func transform(input: Input) -> Output {
        
        let getUsersEvent: Driver<Lce<[User]>> = dependencies.userService.getUsers().asDriverOnErrorJustComplete()
        
        let downloadUsersEvent = input.page.flatMap({ (page) -> Observable<Lce<[User]>> in
            return self.dependencies.userService.downloadUsersForPage(page)
        }).asDriverOnErrorJustComplete()
        
        return Output(getUsersEvent: getUsersEvent, downloadUsersEvent: downloadUsersEvent)
    }
}
