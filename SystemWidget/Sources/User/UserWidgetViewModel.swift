//
//  Created by Tomas Brand on 05.12.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Combine
import DomainLayer
import Foundation
import RxCombine
import RxSwift

final class UserWidgetViewModel: ObservableObject {
    
    // MARK: - Publishers
    @Published public var viewData: UserWidgetViewData = .noData
    @Published public var user: User?
    
    // MARK: - Private properties
    private var widgetService: WidgetDataUseCaseProtocol?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    public func onAppear(userId: String) {
        getUser(userId: userId)
    }
    
    // MARK: - Private methods
    private func getUser(userId: String) {
        guard let service = widgetService else {
            viewData = .loggedOut
            return
        }
        
        service.execute(id: userId)
            .publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { user in
                    self.user = user
                }
            )
            .store(in: &cancellables)
    }
}

enum UserWidgetViewData: Equatable {
    struct UserData: Equatable {
        let name: String
        let pictureUrl: String
    }

    case user(UserData)
    case loggedOut
    case noData
}
