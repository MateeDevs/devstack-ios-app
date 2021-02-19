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
    
    typealias Dependencies = HasUserRepository

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
        
        let users = dependencies.userRepository.getUsers().share(replay: 1)
        
        let activity = ActivityIndicator()
        
        let refreshUsers = page.flatMap { page -> Observable<Event<Int>> in
            dependencies.userRepository.refreshUsersForPage(page).trackActivity(activity)
        }.share()
        
        let isRefreshing = Observable<Bool>.merge(
            activity.asObservable(),
            refreshUsers.map { _ in false }
        )

        // MARK: Setup outputs
        
        self.output = Output(
            users: users.asDriver(),
            loadedCount: refreshUsers.compactMap { $0.element }.asDriver(),
            isRefreshing: isRefreshing.asDriver()
        )
        
        super.init()
    }
}
