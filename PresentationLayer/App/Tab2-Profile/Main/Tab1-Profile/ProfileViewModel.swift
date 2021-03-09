//
//  Created by Petr Chmelar on 09/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import CoreLocation
import RxCocoa
import RxSwift

final class ProfileViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies =
        HasGetProfileUseCase &
        HasRefreshProfileUseCase &
        HasLogoutUseCase &
        HasGetCurrentLocationUseCase &
        HasGetRemoteConfigValueUseCase
    
    let input: Input
    let output: Output
    
    struct Input {
        let logoutButtonTaps: AnyObserver<Void>
    }
    
    struct Output {
        let profile: Profile
        let isRefreshing: Driver<Bool>
        let currentLocation: Driver<String>
        let additionalInfoLabelIsHidden: Driver<Bool>
        let flow: Driver<ProfileViewControllerFlow>
    }

    struct Profile {
        let fullName: Driver<String>
        let initials: Driver<String>
        let imageURL: Driver<String?>
    }
    
    init(dependencies: Dependencies) {
        
        // MARK: Setup inputs

        let logoutButtonTaps = PublishSubject<Void>()
        
        self.input = Input(
            logoutButtonTaps: logoutButtonTaps.asObserver()
        )
        
        // MARK: Transformations
        
        let activity = ActivityIndicator()

        let profile = dependencies.getProfileUseCase.execute().share(replay: 1)
        let refreshProfile = dependencies.refreshProfileUseCase.execute().trackActivity(activity).share()
        
        let isRefreshing = Observable<Bool>.merge(
            activity.asObservable(),
            refreshProfile.map { _ in false }
        )
        
        let currentLocation = dependencies.getCurrentLocationUseCase.execute().take(1)
        
        let additionalInfoLabelIsHidden = dependencies.getRemoteConfigValueUseCase.execute(.profileAdditionalInfoIsVisible).map { !$0 }

        let logout = logoutButtonTaps.flatMapLatest { _ -> Observable<Event<Void>> in
            return dependencies.logoutUseCase.execute()
        }.share()

        // MARK: Setup outputs
        
        self.output = Output(
            profile: Profile(
                fullName: profile.map { $0.fullName }.asDriver(),
                initials: profile.map { $0.fullName.initials }.asDriver(),
                imageURL: profile.map { $0.pictureUrl }.asDriver()
            ),
            isRefreshing: isRefreshing.asDriver(),
            currentLocation: currentLocation.map { $0.coordinate.toString() }.asDriver(),
            additionalInfoLabelIsHidden: additionalInfoLabelIsHidden.asDriver(),
            flow: logout.compactMap { $0.element }.map { .presentOnboarding }.asDriver()
        )
        
        super.init()
    }
}