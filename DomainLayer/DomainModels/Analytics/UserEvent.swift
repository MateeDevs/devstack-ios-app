//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public enum UserAnalyticsEvent: AnalyticsEvent {
    case userDetail(id: String)
    
    public var name: String {
        switch self {
        case .userDetail: return "user_detail"
        }
    }
    
    public var params: [String: Any] {
        switch self {
        case .userDetail(let id): return ["id": id]
        }
    }
}
