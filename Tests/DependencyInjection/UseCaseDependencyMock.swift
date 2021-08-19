//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DependencyInjection
import protocol DevstackKmpShared.GetBooksUseCase
import protocol DevstackKmpShared.RefreshBooksUseCase
import DomainLayer

struct UseCaseDependencyMock: UseCaseDependency {
    
    let loginUseCase: LoginUseCase
    let logoutUseCase: LogoutUseCase
    let registrationUseCase: RegistrationUseCase
    
    let getCurrentLocationUseCase: GetCurrentLocationUseCase
    
    let getProfileUseCase: GetProfileUseCase
    let getProfileIdUseCase: GetProfileIdUseCase
    let refreshProfileUseCase: RefreshProfileUseCase
    let updateProfileCounterUseCase: UpdateProfileCounterUseCase
    
    let handlePushNotificationUseCase: HandlePushNotificationUseCase
    let registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCase
    
    let getRemoteConfigValueUseCase: GetRemoteConfigValueUseCase
    
    let getUserUseCase: GetUserUseCase
    let refreshUserUseCase: RefreshUserUseCase
    let updateUserUseCase: UpdateUserUseCase
    
    let getUsersUseCase: GetUsersUseCase
    let refreshUsersUseCase: RefreshUsersUseCase
    
//    let getBooksUseCase: GetBooksUseCase
//    let refreshBooksUseCase: RefreshBooksUseCase
    
    init(
        loginUseCase: LoginUseCase = LoginUseCaseMock(),
        logoutUseCase: LogoutUseCase = LogoutUseCaseMock(),
        registrationUseCase: RegistrationUseCase = RegistrationUseCaseMock(),
        getCurrentLocationUseCase: GetCurrentLocationUseCase = GetCurrentLocationUseCaseMock(),
        getProfileUseCase: GetProfileUseCase = GetProfileUseCaseMock(),
        getProfileIdUseCase: GetProfileIdUseCase = GetProfileIdUseCaseMock(),
        refreshProfileUseCase: RefreshProfileUseCase = RefreshProfileUseCaseMock(),
        updateProfileCounterUseCase: UpdateProfileCounterUseCase = UpdateProfileCounterUseCaseMock(),
        handlePushNotificationUseCase: HandlePushNotificationUseCase = HandlePushNotificationUseCaseMock(),
        registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCase = RegisterForPushNotificationsUseCaseMock(),
        getRemoteConfigValueUseCase: GetRemoteConfigValueUseCase = GetRemoteConfigValueUseCaseMock(),
        getUserUseCase: GetUserUseCase = GetUserUseCaseMock(),
        refreshUserUseCase: RefreshUserUseCase = RefreshUserUseCaseMock(),
        updateUserUseCase: UpdateUserUseCase = UpdateUserUseCaseMock(),
        getUsersUseCase: GetUsersUseCase = GetUsersUseCaseMock(),
        refreshUsersUseCase: RefreshUsersUseCase = RefreshUsersUseCaseMock()/*,
        getBooksUseCase: GetBooksUseCase = GetBooksUseCaseMock(),
        refreshBooksUseCase: RefreshBooksUseCase = RefreshBooksUseCaseMock()*/
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
//        self.getBooksUseCase = getBooksUseCase
//        self.refreshBooksUseCase = refreshBooksUseCase
    }
}
