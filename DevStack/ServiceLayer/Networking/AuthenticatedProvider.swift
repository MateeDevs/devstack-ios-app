//
//  AuthenticatedProvider.swift
//  DevStack
//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Qest. All rights reserved.
//
// Custom Moya provider
// Idea taken from: https://github.com/Moya/Moya/blob/master/docs/Examples/ComposingProvider.md
//

import Foundation
import Moya
import Alamofire
import RxSwift

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
            if let authToken = KeychainStore.get(key: KeychainCoding.authToken) {
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
        
        // Configure manager
        let configuration = URLSessionConfiguration.default
        let manager = Alamofire.SessionManager(configuration: configuration)
        
        // Configure plugins
        var plugins: [PluginType] = []
        plugins.append(CustomNetworkActivityPlugin())
        #if DEBUG
        plugins.append(NetworkLoggerPlugin(verbose: true, cURL: true, responseDataFormatter: { (_ data: Data) -> Data in
            do {
                let dataAsJSON = try JSONSerialization.jsonObject(with: data)
                let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
                return prettyData
            } catch {
                // Fallback to original data if it can't be serialized
                return data
            }
        }))
        #endif
        
        provider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, requestClosure: requestClosure, manager: manager, plugins: plugins)
    }
    
    func request(_ target: MultiTarget) -> Single<Moya.Response> {
        let actualRequest = provider.rx.request(target).flatMap { (response) -> PrimitiveSequence<SingleTrait, Response> in
            if response.statusCode == 401 {
                #warning("TODO: do something clever")
                return Single.just(response)
            } else {
                return Single.just(response)
            }
        }
        return actualRequest
    }
    
}
