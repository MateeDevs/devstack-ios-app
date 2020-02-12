//
//  WeatherService.swift
//  DevStack
//
//  Created by Filip Bodnár on 11/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation
import RxSwift

public protocol HasWeatherService {
    var weatherService: WeatherService { get }
}

public class WeatherService {
    
    private let database = DatabaseManager()
    private let network = NetworkManager()


    public func getWeatherDataWOEID(_ woeid: Int) -> Observable<Lce<[Clima]>> {
        let endpoint = WeatherAPI.getWeatherByLocation(woeid)
        
        return network.observableRequest(endpoint).map([Clima].self, atKeyPath: "consolidated_weather").save().mapToLce()
    }
}
