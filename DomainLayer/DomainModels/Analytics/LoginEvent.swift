//
//  Created by Petr Chmelar on 26.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public enum LoginAnalyticsEvent: AnalyticsEvent {
    case screenAppear // Just for a show case purposes, already tracked by default
    case loginButtonTap
    case registerButtonTap
    
    public var name: String {
        switch self {
        case .screenAppear: return "login_screen"
        case .loginButtonTap: return "login_button_tap"
        case .registerButtonTap: return "register_button_tap"
        }
    }
    
    public var params: [String: Any] {
        return [:]
    }
}
