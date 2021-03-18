//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

// swiftlint:disable superfluous_disable_command file_length

struct UseCaseDependencyMock: UseCaseDependencyType {
    
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
        loginUseCase: LoginUseCaseType = LoginUseCaseTypeMock(),
        logoutUseCase: LogoutUseCaseType = LogoutUseCaseTypeMock(),
        registrationUseCase: RegistrationUseCaseType = RegistrationUseCaseTypeMock(),
        getCurrentLocationUseCase: GetCurrentLocationUseCaseType = GetCurrentLocationUseCaseTypeMock(),
        getProfileUseCase: GetProfileUseCaseType = GetProfileUseCaseTypeMock(),
        getProfileIdUseCase: GetProfileIdUseCaseType = GetProfileIdUseCaseTypeMock(),
        refreshProfileUseCase: RefreshProfileUseCaseType = RefreshProfileUseCaseTypeMock(),
        updateProfileCounterUseCase: UpdateProfileCounterUseCaseType = UpdateProfileCounterUseCaseTypeMock(),
        handlePushNotificationUseCase: HandlePushNotificationUseCaseType = HandlePushNotificationUseCaseTypeMock(),
        registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCaseType = RegisterForPushNotificationsUseCaseTypeMock(),
        getRemoteConfigValueUseCase: GetRemoteConfigValueUseCaseType = GetRemoteConfigValueUseCaseTypeMock(),
        getUserUseCase: GetUserUseCaseType = GetUserUseCaseTypeMock(),
        refreshUserUseCase: RefreshUserUseCaseType = RefreshUserUseCaseTypeMock(),
        updateUserUseCase: UpdateUserUseCaseType = UpdateUserUseCaseTypeMock(),
        getUsersUseCase: GetUsersUseCaseType = GetUsersUseCaseTypeMock(),
        refreshUsersUseCase: RefreshUsersUseCaseType = RefreshUsersUseCaseTypeMock()
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
