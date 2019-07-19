//
//  BiometricHelper.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/07/2019.
//  Copyright © 2019 Qest. All rights reserved.
//

import LocalAuthentication

public enum BiometricType {
    case none
    case touch
    case face
}

public struct Biometric {
    
    ///
    /// Checks which type of biometric is supported
    ///
    /// - returns: Supported biometric
    ///
    public static func biometricType() -> BiometricType {
        let authContext = LAContext()
        if #available(iOS 11, *) {
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(authContext.biometryType) {
            case .touchID:
                return .touch
            case .faceID:
                return .face
            default:
                return .none
            }
        } else {
            return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
        }
    }
}
