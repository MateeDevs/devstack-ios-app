//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DataLayer
import DomainLayer

// swiftlint:disable superfluous_disable_command file_length

public protocol UseCaseDependency: HasNoUseCase,
    HasLoginUseCase,
    HasLogoutUseCase,
    HasRegistrationUseCase,
    HasGetCurrentLocationUseCase,
    HasGetProfileUseCase,
    HasGetProfileIdUseCase,
    HasRefreshProfileUseCase,
    HasUpdateProfileCounterUseCase,
    HasHandlePushNotificationUseCase,
    HasRegisterForPushNotificationsUseCase,
    HasGetRemoteConfigValueUseCase,
    HasGetUserUseCase,
    HasRefreshUserUseCase,
    HasUpdateUserUseCase,
    HasGetUsersUseCase,
    HasRefreshUsersUseCase {}

public struct UseCaseDependencyImpl: UseCaseDependency {
    
    public let loginUseCase: LoginUseCase
    public let logoutUseCase: LogoutUseCase
    public let registrationUseCase: RegistrationUseCase
    
    public let getCurrentLocationUseCase: GetCurrentLocationUseCase
    
    public let getProfileUseCase: GetProfileUseCase
    public let getProfileIdUseCase: GetProfileIdUseCase
    public let refreshProfileUseCase: RefreshProfileUseCase
    public let updateProfileCounterUseCase: UpdateProfileCounterUseCase
    
    public let handlePushNotificationUseCase: HandlePushNotificationUseCase
    public let registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCase
    
    public let getRemoteConfigValueUseCase: GetRemoteConfigValueUseCase
    
    public let getUserUseCase: GetUserUseCase
    public let refreshUserUseCase: RefreshUserUseCase
    public let updateUserUseCase: UpdateUserUseCase
    
    public let getUsersUseCase: GetUsersUseCase
    public let refreshUsersUseCase: RefreshUsersUseCase
    
    public init(dependencies: RepositoryDependency) {
        self.loginUseCase = LoginUseCaseImpl(dependencies: dependencies)
        self.logoutUseCase = LogoutUseCaseImpl(dependencies: dependencies)
        self.registrationUseCase = RegistrationUseCaseImpl(dependencies: dependencies)
        
        self.getCurrentLocationUseCase = GetCurrentLocationUseCaseImpl(dependencies: dependencies)
        
        self.getProfileUseCase = GetProfileUseCaseImpl(dependencies: dependencies)
        self.getProfileIdUseCase = GetProfileIdUseCaseImpl(dependencies: dependencies)
        self.refreshProfileUseCase = RefreshProfileUseCaseImpl(dependencies: dependencies)
        self.updateProfileCounterUseCase = UpdateProfileCounterUseCaseImpl(dependencies: dependencies)
        
        self.handlePushNotificationUseCase = HandlePushNotificationUseCaseImpl(dependencies: dependencies)
        self.registerForPushNotificationsUseCase = RegisterForPushNotificationsUseCaseImpl(dependencies: dependencies)
        
        self.getRemoteConfigValueUseCase = GetRemoteConfigValueUseCaseImpl(dependencies: dependencies)
        
        self.getUserUseCase = GetUserUseCaseImpl(dependencies: dependencies)
        self.refreshUserUseCase = RefreshUserUseCaseImpl(dependencies: dependencies)
        self.updateUserUseCase = UpdateUserUseCaseImpl(dependencies: dependencies)
        
        self.getUsersUseCase = GetUsersUseCaseImpl(dependencies: dependencies)
        self.refreshUsersUseCase = RefreshUsersUseCaseImpl(dependencies: dependencies)
    }
}
