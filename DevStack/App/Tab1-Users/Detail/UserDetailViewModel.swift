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
    
    typealias Dependencies =
        HasGetUserUseCase &
        HasRefreshUserUseCase
    
    let input: Input
    let output: Output
    
    struct Input {
        let refreshTrigger: AnyObserver<Void>
    }
    
    struct Output {
        let user: OutputUser
        let isRefreshing: Driver<Bool>
    }

    struct OutputUser {
        let fullName: Driver<String>
        let initials: Driver<String>
        let imageURL: Driver<String?>
    }
    
    init(dependencies: Dependencies, userId: String) {
        
        // MARK: Setup inputs
        
        let refreshTrigger = PublishSubject<Void>()
        
        self.input = Input(
            refreshTrigger: refreshTrigger.asObserver()
        )

        // MARK: Transformations
        
        let user = dependencies.getUserUseCase.execute(id: userId).share(replay: 1)
        
        let activity = ActivityIndicator()
        
        let refreshUser = refreshTrigger.flatMap { _ -> Observable<Event<Void>> in
            dependencies.refreshUserUseCase.execute(id: userId).trackActivity(activity)
        }.share()
        
        let isRefreshing = Observable<Bool>.merge(
            activity.asObservable(),
            refreshUser.map { _ in false }
        )

        // MARK: Setup outputs
        
        self.output = Output(
            user: OutputUser(
                fullName: user.map { $0.fullName }.asDriver(),
                initials: user.map { $0.fullName.initials }.asDriver(),
                imageURL: user.map { $0.pictureUrl }.asDriver()
            ),
            isRefreshing: isRefreshing.asDriver()
        )
        
        super.init()
    }
}
