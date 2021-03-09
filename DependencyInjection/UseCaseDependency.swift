//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DataLayer
import DomainLayer

// swiftlint:disable superfluous_disable_command file_length

extension UseCaseDependency: HasNoUseCase {}

extension UseCaseDependency: HasLoginUseCase {}
extension UseCaseDependency: HasLogoutUseCase {}
extension UseCaseDependency: HasRegistrationUseCase {}

extension UseCaseDependency: HasGetCurrentLocationUseCase {}

extension UseCaseDependency: HasGetProfileUseCase {}
extension UseCaseDependency: HasGetProfileIdUseCase {}
extension UseCaseDependency: HasRefreshProfileUseCase {}
extension UseCaseDependency: HasUpdateProfileCounterUseCase {}

extension UseCaseDependency: HasDecodePushNotificationUseCase {}
extension UseCaseDependency: HasRegisterForPushNotificationsUseCase {}

extension UseCaseDependency: HasGetRemoteConfigValueUseCase {}

extension UseCaseDependency: HasGetUserUseCase {}
extension UseCaseDependency: HasRefreshUserUseCase {}
extension UseCaseDependency: HasUpdateUserUseCase {}

extension UseCaseDependency: HasGetUsersUseCase {}
extension UseCaseDependency: HasRefreshUsersUseCase {}

public struct UseCaseDependency {
    
    public let loginUseCase: LoginUseCase
    public let logoutUseCase: LogoutUseCase
    public let registrationUseCase: RegistrationUseCase
    
    public let getCurrentLocationUseCase: GetCurrentLocationUseCase
    
    public let getProfileUseCase: GetProfileUseCase
    public let getProfileIdUseCase: GetProfileIdUseCase
    public let refreshProfileUseCase: RefreshProfileUseCase
    public let updateProfileCounterUseCase: UpdateProfileCounterUseCase
    
    public let decodePushNotificationUseCase: DecodePushNotificationUseCase
    public let registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCase
    
    public let getRemoteConfigValueUseCase: GetRemoteConfigValueUseCase
    
    public let getUserUseCase: GetUserUseCase
    public let refreshUserUseCase: RefreshUserUseCase
    public let updateUserUseCase: UpdateUserUseCase
    
    public let getUsersUseCase: GetUsersUseCase
    public let refreshUsersUseCase: RefreshUsersUseCase
    
    public init(dependencies: RepositoryDependency) {
        self.loginUseCase = LoginUseCase(dependencies: dependencies)
        self.logoutUseCase = LogoutUseCase(dependencies: dependencies)
        self.registrationUseCase = RegistrationUseCase(dependencies: dependencies)
        
        self.getCurrentLocationUseCase = GetCurrentLocationUseCase(dependencies: dependencies)
        
        self.getProfileUseCase = GetProfileUseCase(dependencies: dependencies)
        self.getProfileIdUseCase = GetProfileIdUseCase(dependencies: dependencies)
        self.refreshProfileUseCase = RefreshProfileUseCase(dependencies: dependencies)
        self.updateProfileCounterUseCase = UpdateProfileCounterUseCase(dependencies: dependencies)
        
        self.decodePushNotificationUseCase = DecodePushNotificationUseCase(dependencies: dependencies)
        self.registerForPushNotificationsUseCase = RegisterForPushNotificationsUseCase(dependencies: dependencies)
        
        self.getRemoteConfigValueUseCase = GetRemoteConfigValueUseCase(dependencies: dependencies)
        
        self.getUserUseCase = GetUserUseCase(dependencies: dependencies)
        self.refreshUserUseCase = RefreshUserUseCase(dependencies: dependencies)
        self.updateUserUseCase = UpdateUserUseCase(dependencies: dependencies)
        
        self.getUsersUseCase = GetUsersUseCase(dependencies: dependencies)
        self.refreshUsersUseCase = RefreshUsersUseCase(dependencies: dependencies)
    }
}
