//
//  Created by Petr Chmelar on 10.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation

enum Flow {
    case login(LoginViewControllerFlow)
    case registration(RegistrationViewControllerFlow)
    case users(UsersViewControllerFlow)
    case profile(ProfileViewControllerFlow)
    case books(BooksViewControllerFlow)
}
