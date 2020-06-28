//
//  AuthenticatedProvider.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Alamofire
import Foundation
import Moya
import RxSwift

/// Custom Moya provider.
/// - Idea taken from [Moya - ComposingProvider](https://github.com/Moya/Moya/blob/master/docs/Examples/ComposingProvider.md)
final class AuthenticatedProvider<MultiTarget> where MultiTarget: Moya.TargetType {

    private let keychain: KeychainProviderType
    private let database: DatabaseProviderType
    private let moyaProvider: MoyaProvider<MultiTarget>

    init(
        keychainProvider: KeychainProviderType,
        databaseProvider: DatabaseProviderType,
        headers: [String: String] = [:],
        parameters: [String: Any] = [:]
    ) {
        self.keychain = keychainProvider
        self.database = databaseProvider

        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            
            // Add custom headers and parameters
            var defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: headers)
            if !parameters.isEmpty {
                defaultEndpoint = defaultEndpoint.replacing(
                    task: .requestParameters(parameters: parameters, encoding: URLEncoding.default)
                )
            }
            
            // Add service headers
            defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: [
                "Client-Type": "ios",
                "Client-App": Bundle.main.bundleIdentifier ?? "undefined",
                "Client-AppVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "undefined",
                "Client-API": "\(NetworkingConstants.apiVersion)",
                "Client-OS": UIDevice.current.systemVersion,
                "Client-HW": UIDevice.current.identifierForVendor?.uuidString ?? "undefined"
            ])
            
            // Add auth header to every request if available
            if let authToken = keychainProvider.get(.authToken) {
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
        
        moyaProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, requestClosure: requestClosure, plugins: plugins)
    }
    
    func request(_ target: MultiTarget, withInterceptor: Bool = true) -> Single<Moya.Response> {
        let actualRequest = moyaProvider.rx.request(target).flatMap { response -> PrimitiveSequence<SingleTrait, Response> in
            if response.statusCode == 401 {
                guard withInterceptor,
                    let vc = UIApplication.topViewController() as? BaseViewController else { return Single.just(response) }

				let action = UIAlertAction(title: L10n.dialog_interceptor_button_title, style: .default, handler: { _ in
                    // Perform logout and present login screen
                    self.keychain.deleteAll()
                    self.database.deleteAll()
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                        let mainFlow = appDelegate.flowController?.childControllers.first as? MainFlowController {
                        mainFlow.presentOnboarding()
                    }
                })
                
                let alert = Alert(title: L10n.dialog_interceptor_title, message: L10n.dialog_interceptor_text, primaryAction: action)
                vc.handleAlertAction(.showAlert(alert))
                return Single.error(MoyaError.statusCode(response))
            } else {
                return Single.just(response)
            }
        }
        return actualRequest
    }
    
}
