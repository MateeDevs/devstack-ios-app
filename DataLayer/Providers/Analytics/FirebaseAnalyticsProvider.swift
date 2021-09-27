//
//  Created by Petr Chmelar on 26.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import FirebaseAnalytics

public struct FirebaseAnalyticsProvider {
    public init() {}
}

extension FirebaseAnalyticsProvider: AnalyticsProvider {
    
    public func track(_ event: TrackableEvent) {
        Analytics.logEvent(event.name, parameters: event.params)
    }
}
