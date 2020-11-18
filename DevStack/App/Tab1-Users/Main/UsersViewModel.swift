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
        let users: Driver<[User]>
        let loadedCount: Driver<Int>
        let isRefreshing: Driver<Bool>
    }
    
    init(dependencies: Dependencies) {
        
        // MARK: Setup inputs
        
        let page = PublishSubject<Int>()
        
        self.input = Input(
            page: page.asObserver()
        )

        // MARK: Transformations
        
        let users = dependencies.userService.getUsers()
        
        let activity = ActivityIndicator()
        
        let refreshUsers = page.flatMap({ page -> Observable<Event<[User]>> in
            dependencies.userService.downloadUsersForPage(page).trackActivity(activity).materialize()
        }).share()
        
        let loadedCount = refreshUsers.compactMap { $0.element }.map { $0.count }
        
        let isRefreshing: Observable<Bool> = Observable.merge(
            activity.asObservable(),
            refreshUsers.map { _ in false }
        )

        // MARK: Setup outputs
        
        self.output = Output(
            users: users.asDriver(),
            loadedCount: loadedCount.asDriver(),
            isRefreshing: isRefreshing.asDriver()
        )
        
        super.init()
    }
}
