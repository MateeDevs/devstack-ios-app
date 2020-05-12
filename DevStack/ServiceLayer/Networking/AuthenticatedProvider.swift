//
//  AuthenticatedProvider.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import RxSwift

/// Custom Moya provider.
/// - Idea taken from [Moya - ComposingProvider](https://github.com/Moya/Moya/blob/master/docs/Examples/ComposingProvider.md)
final class AuthenticatedProvider<MultiTarget> where MultiTarget: Moya.TargetType {
    
    private let provider: MoyaProvider<MultiTarget>
    
    init(headers: [String: String] = [:], parameters: [String: Any] = [:]) {
        
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            
            // Add custom headers and parameters
            var defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: headers)
            if parameters.count > 0 {
                defaultEndpoint = defaultEndpoint.replacing(task: .requestParameters(parameters: parameters, encoding: URLEncoding.default))
            }
            
            // Add service headers
            defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: ["Client-Type": "ios"])
            defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: ["Client-App": "\(Bundle.main.bundleIdentifier!)[\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)]"])
            defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: ["Client-API": "\(NetworkingConstants.apiVersion)"])
            defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: ["Client-OS": UIDevice.current.systemVersion])
            defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: ["Client-HW": UIDevice.current.identifierForVendor!.uuidString])
            
            // Add auth header to every request if available
            if let authToken = KeychainProvider.get(.authToken) {
                defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: ["Authorization": "Bearer \(authToken)"])
            }
            
            return defaultEndpoint
        }
        
        let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
            do {
                let request = try endpoint.urlRequest()
                done(.success(request))
            } catch let error as NSError {
                Logger.error("Moya request closure error:\n%@", "\(error)", category: .networking)
                return
            }
        }
        
        // Configure plugins
        var plugins: [PluginType] = []
        plugins.append(CustomNetworkActivityPlugin())
        #if DEBUG
        let loggerConfig = NetworkLoggerPlugin.Configuration(
            formatter: NetworkLoggerPlugin.Configuration.Formatter(responseData: { (_ data: Data) -> String in
                do {
                    let dataAsJSON = try JSONSerialization.jsonObject(with: data)
                    let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
                    return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
                } catch {
                    return String(data: data, encoding: .utf8) ?? ""
                }
            }),
            logOptions: [.verbose, .formatRequestAscURL]
        )
        plugins.append(NetworkLoggerPlugin(configuration: loggerConfig))
        #endif
        
        provider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, requestClosure: requestClosure, plugins: plugins)
    }
    
    func request(_ target: MultiTarget, withInterceptor: Bool = true) -> Single<Moya.Response> {
        let actualRequest = provider.rx.request(target).flatMap { (response) -> PrimitiveSequence<SingleTrait, Response> in
            if response.statusCode == 401 {
                guard withInterceptor, let vc = UIApplication.topViewController() as? BaseViewController else { return Single.just(response) }

				let action = UIAlertAction(title: L10n.dialog_interceptor_button_title, style: .default, handler: { _ in
                    // Perform logout and present login screen
                    LoginService.logout()
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                        let mainFlow = appDelegate.flowController.childControllers.first as? MainFlowController {
                        mainFlow.presentOnboarding()
                    }
                })
                
				vc.showAlert(title: L10n.dialog_interceptor_title, message: L10n.dialog_interceptor_text, primaryAction: action)
                return Single.error(MoyaError.statusCode(response))
            } else {
                return Single.just(response)
            }
        }
        return actualRequest
    }
    
}
