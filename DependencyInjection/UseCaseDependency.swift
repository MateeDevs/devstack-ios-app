//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DataLayer
import DevstackKmpShared
import DomainLayer

// swiftlint:disable superfluous_disable_command file_length

public protocol UseCaseDependencyType: HasNoUseCase,
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
    HasRefreshUsersUseCase,
    HasBookUseCases {}

public struct UseCaseDependency: UseCaseDependencyType {
    
    public let loginUseCase: LoginUseCaseType
    public let logoutUseCase: LogoutUseCaseType
    public let registrationUseCase: RegistrationUseCaseType
    
    public let getCurrentLocationUseCase: GetCurrentLocationUseCaseType
    
    public let getProfileUseCase: GetProfileUseCaseType
    public let getProfileIdUseCase: GetProfileIdUseCaseType
    public let refreshProfileUseCase: RefreshProfileUseCaseType
    public let updateProfileCounterUseCase: UpdateProfileCounterUseCaseType
    
    public let handlePushNotificationUseCase: HandlePushNotificationUseCaseType
    public let registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCaseType
    
    public let getRemoteConfigValueUseCase: GetRemoteConfigValueUseCaseType
    
    public let getUserUseCase: GetUserUseCaseType
    public let refreshUserUseCase: RefreshUserUseCaseType
    public let updateUserUseCase: UpdateUserUseCaseType
    
    public let getUsersUseCase: GetUsersUseCaseType
    public let refreshUsersUseCase: RefreshUsersUseCaseType
    
    public let getBooksUseCase: GetBooksUseCase
    public let refreshBooksUseCase: RefreshBooksUseCase
    
    public init(dependencies: RepositoryDependency, kmpDependencies: KMPDependency) {
        self.loginUseCase = LoginUseCase(dependencies: dependencies)
        self.logoutUseCase = LogoutUseCase(dependencies: dependencies)
        self.registrationUseCase = RegistrationUseCase(dependencies: dependencies)
        
        self.getCurrentLocationUseCase = GetCurrentLocationUseCase(dependencies: dependencies)
        
        self.getProfileUseCase = GetProfileUseCase(dependencies: dependencies)
        self.getProfileIdUseCase = GetProfileIdUseCase(dependencies: dependencies)
        self.refreshProfileUseCase = RefreshProfileUseCase(dependencies: dependencies)
        self.updateProfileCounterUseCase = UpdateProfileCounterUseCase(dependencies: dependencies)
        
        self.handlePushNotificationUseCase = HandlePushNotificationUseCase(dependencies: dependencies)
        self.registerForPushNotificationsUseCase = RegisterForPushNotificationsUseCase(dependencies: dependencies)
        
        self.getRemoteConfigValueUseCase = GetRemoteConfigValueUseCase(dependencies: dependencies)
        
        self.getUserUseCase = GetUserUseCase(dependencies: dependencies)
        self.refreshUserUseCase = RefreshUserUseCase(dependencies: dependencies)
        self.updateUserUseCase = UpdateUserUseCase(dependencies: dependencies)
        
        self.getUsersUseCase = GetUsersUseCase(dependencies: dependencies)
        self.refreshUsersUseCase = RefreshUsersUseCase(dependencies: dependencies)
        
        self.getBooksUseCase = kmpDependencies.get(GetBooksUseCase.self)
        self.refreshBooksUseCase = kmpDependencies.get(RefreshBooksUseCase.self)
        
    }
}
