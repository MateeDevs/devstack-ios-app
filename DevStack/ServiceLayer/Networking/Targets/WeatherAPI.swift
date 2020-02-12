//
//  WeatherAPI.swift
//  DevStack
//
//  Created by Filip Bodnár on 11/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation
import Moya

enum WeatherAPI {
    case getWeatherByLocation(_ woeid: Int)
}

extension WeatherAPI: TargetType {
    var baseURL: URL { URL(string: "https://www.metaweather.com/api")! }
    
    var path: String {
        switch self {
        case .getWeatherByLocation(let woeid):
            return "/location/\(woeid)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var headers: [String: String]? {
        nil
    }
    
    var task: Task {
        switch self {
        case .getWeatherByLocation:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
}
