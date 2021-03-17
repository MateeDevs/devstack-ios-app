//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

// swiftlint:disable superfluous_disable_command file_length

extension UseCaseDependencyMock: HasNoUseCase {}

extension UseCaseDependencyMock: HasLoginUseCase {}
extension UseCaseDependencyMock: HasLogoutUseCase {}
extension UseCaseDependencyMock: HasRegistrationUseCase {}

extension UseCaseDependencyMock: HasGetCurrentLocationUseCase {}

extension UseCaseDependencyMock: HasGetProfileUseCase {}
extension UseCaseDependencyMock: HasGetProfileIdUseCase {}
extension UseCaseDependencyMock: HasRefreshProfileUseCase {}
extension UseCaseDependencyMock: HasUpdateProfileCounterUseCase {}

extension UseCaseDependencyMock: HasHandlePushNotificationUseCase {}
extension UseCaseDependencyMock: HasRegisterForPushNotificationsUseCase {}

extension UseCaseDependencyMock: HasGetRemoteConfigValueUseCase {}

extension UseCaseDependencyMock: HasGetUserUseCase {}
extension UseCaseDependencyMock: HasRefreshUserUseCase {}
extension UseCaseDependencyMock: HasUpdateUserUseCase {}

extension UseCaseDependencyMock: HasGetUsersUseCase {}
extension UseCaseDependencyMock: HasRefreshUsersUseCase {}

struct UseCaseDependencyMock {
    
    let loginUseCase: LoginUseCaseType
    let logoutUseCase: LogoutUseCaseType
    let registrationUseCase: RegistrationUseCaseType
    
    let getCurrentLocationUseCase: GetCurrentLocationUseCaseType
    
    let getProfileUseCase: GetProfileUseCaseType
    let getProfileIdUseCase: GetProfileIdUseCaseType
    let refreshProfileUseCase: RefreshProfileUseCaseType
    let updateProfileCounterUseCase: UpdateProfileCounterUseCaseType
    
    let handlePushNotificationUseCase: HandlePushNotificationUseCaseType
    let registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCaseType
    
    let getRemoteConfigValueUseCase: GetRemoteConfigValueUseCaseType
    
    let getUserUseCase: GetUserUseCaseType
    let refreshUserUseCase: RefreshUserUseCaseType
    let updateUserUseCase: UpdateUserUseCaseType
    
    let getUsersUseCase: GetUsersUseCaseType
    let refreshUsersUseCase: RefreshUsersUseCaseType
    
    init(
        loginUseCase: LoginUseCaseType = LoginUseCaseMock(returnValue: .empty()),
        logoutUseCase: LogoutUseCaseType = LogoutUseCaseMock(),
        registrationUseCase: RegistrationUseCaseType = RegistrationUseCaseMock(returnValue: .empty()),
        getCurrentLocationUseCase: GetCurrentLocationUseCaseType = GetCurrentLocationUseCaseMock(returnValue: .empty()),
        getProfileUseCase: GetProfileUseCaseType = GetProfileUseCaseMock(returnValue: .empty()),
        getProfileIdUseCase: GetProfileIdUseCaseType = GetProfileIdUseCaseMock(returnValue: nil),
        refreshProfileUseCase: RefreshProfileUseCaseType = RefreshProfileUseCaseMock(returnValue: .empty()),
        updateProfileCounterUseCase: UpdateProfileCounterUseCaseType = UpdateProfileCounterUseCaseMock(returnValue: .empty()),
        handlePushNotificationUseCase: HandlePushNotificationUseCaseType = HandlePushNotificationUseCaseMock(returnValue: nil),
        registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCaseType = RegisterForPushNotificationsUseCaseMock(),
        getRemoteConfigValueUseCase: GetRemoteConfigValueUseCaseType = GetRemoteConfigValueUseCaseMock(returnValue: .empty()),
        getUserUseCase: GetUserUseCaseType = GetUserUseCaseMock(returnValue: .empty()),
        refreshUserUseCase: RefreshUserUseCaseType = RefreshUserUseCaseMock(returnValue: .empty()),
        updateUserUseCase: UpdateUserUseCaseType = UpdateUserUseCaseMock(returnValue: .empty()),
        getUsersUseCase: GetUsersUseCaseType = GetUsersUseCaseMock(returnValue: .empty()),
        refreshUsersUseCase: RefreshUsersUseCaseType = RefreshUsersUseCaseMock(returnValue: .empty())
    ) {
        self.loginUseCase = loginUseCase
        self.logoutUseCase = logoutUseCase
        self.registrationUseCase = registrationUseCase
        self.getCurrentLocationUseCase = getCurrentLocationUseCase
        self.getProfileUseCase = getProfileUseCase
        self.getProfileIdUseCase = getProfileIdUseCase
        self.refreshProfileUseCase = refreshProfileUseCase
        self.updateProfileCounterUseCase = updateProfileCounterUseCase
        self.handlePushNotificationUseCase = handlePushNotificationUseCase
        self.registerForPushNotificationsUseCase = registerForPushNotificationsUseCase
        self.getRemoteConfigValueUseCase = getRemoteConfigValueUseCase
        self.getUserUseCase = getUserUseCase
        self.refreshUserUseCase = refreshUserUseCase
        self.updateUserUseCase = updateUserUseCase
        self.getUsersUseCase = getUsersUseCase
        self.refreshUsersUseCase = refreshUsersUseCase
    }
}
