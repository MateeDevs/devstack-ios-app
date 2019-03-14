//
//  CustomNetworkActivityPlugin.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import Moya
import Result

final class CustomNetworkActivityPlugin: PluginType {
    
    /// Called by the provider as soon as the request is about to start.
    func willSend(_ request: RequestType, target: TargetType) {
    }
    
    /// Called by the provider as soon as a response arrives, even if the request is cancelled.
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        #warning("FIXME: Find better way to show no connection alert")
//        if case Result.success(_) = result {
//            AlertHandler.hideWhisper()
//        } else {
//            AlertHandler.showWhisper(message: L10n.errorNoInternetConnection, type: .error)
//        }
    }
}
