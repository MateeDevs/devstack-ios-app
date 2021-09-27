//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public enum UserAnalyticsEvent: AnalyticsEvent {
    case openUserDetail(id: String)
    
    public var name: String {
        switch self {
        case .openUserDetail: return "open_user_detail"
        }
    }
    
    public var params: [String: Any] {
        switch self {
        case .openUserDetail(let id): return ["id": id]
        }
    }
}
