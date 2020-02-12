// 
//  WeatherViewModel.swift
//  DevStack
//
//  Created by Filip Bodnár on 11/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxSwift
import RxCocoa

final class WeatherViewModel: ViewModel, ViewModelType {
    
    typealias Dependencies = HasWeatherService
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies

        super.init()
    }
    
    struct Input {
        let woeid: Int
    }
    
    struct Output {
        let getClimaByWOEID: Driver<Lce<[Clima]>>
    }
    
    func transform(input: Input) -> Output {
        let WOEID = 796597
        let getClimaByWOEID: Driver<Lce<[Clima]>> = dependencies.weatherService.getWeatherDataWOEID(WOEID).asDriverOnErrorJustComplete()
        return Output(getClimaByWOEID: getClimaByWOEID)
    }
}
