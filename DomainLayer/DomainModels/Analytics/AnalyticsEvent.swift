//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol AnalyticsEvent {
    var name: String { get }
    var params: [String: Any] { get }
}
