//
//  UserDetailViewModel.swift
//  DevStack
//
//  Created by Petr Chmelar on 28/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

final class UserDetailViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasUserService
    
    let input: Input
    let output: Output
    
    struct Input {
        let refreshTrigger: AnyObserver<Void>
    }
    
    struct Output {
        let user: Driver<User>
        let isRefreshing: Driver<Bool>
    }
    
    init(dependencies: Dependencies, userId: String) {
        
        // MARK: Setup inputs
        
        let refreshTrigger = PublishSubject<Void>()
        
        self.input = Input(
            refreshTrigger: refreshTrigger.asObserver()
        )
        
        // MARK: Setup outputs
        
        let user = dependencies.userService.getUserById(userId)
        
        let activity = ActivityIndicator()
        
        let refreshUser = refreshTrigger.flatMap({ _ -> Observable<Event<User>> in
            dependencies.userService.downloadUserById(userId).trackActivity(activity).materialize()
        }).share()
        
        let isRefreshing: Observable<Bool> = Observable.merge(
            activity.asObservable(),
            refreshUser.map { _ in false }
        )
        
        self.output = Output(
            user: user.asDriver(),
            isRefreshing: isRefreshing.asDriver()
        )
        
        super.init()
    }
}
