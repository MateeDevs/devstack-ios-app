// 
//  WeatherViewController.swift
//  DevStack
//
//  Created by Filip Bodnár on 11/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit
import RxSwift

protocol WeatherFlowDelegate: class {
    
}

final class WeatherViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: WeatherFlowController?

    // MARK: ViewModels
    private var viewModel: WeatherViewModel!

    // MARK: UI components
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: Stored properties
    private var forecast: [Clima?] = [] {
         didSet {
            for var (index, item) in forecast.enumerated() { // TODO....
                switch index {
                case 1: // Tomorrow
                    print("Tomorrow", item?.maxTemp)
//                case 2: // Day after Tomorrow
//                case 3:
//                case 4:
//                case 5:
//                case 6:
                default:  // Today
                    print("Today", item?.maxTemp)

                }
                print("item---->", item)
            }
            
            if var currentTemp = forecast[0]?.theTemp, let message = forecast[0]?.weatherStateName {
                temperatureLabel.text = "\(currentTemp.rounded()) °C"
                messageLabel.text = String(describing: message)
            }
         }
     }
    

    // MARK: Initss
    static func instantiate(viewModel: WeatherViewModel) -> WeatherViewController {
        let vc = StoryboardScene.Weather.initialScene.instantiate()
        vc.viewModel = viewModel
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()
        
        let input = WeatherViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.getClimaByWOEID.drive(onNext: { [weak self] event in
            if event.isLoading {
                self?.view.startActivityIndicator()
                
                self?.handleLoadingUI(true)
            } else if let climaData = event.data {
                self?.handleLoadingUI(false)
                
                self?.view.stopActivityIndicator()
                self?.forecast = climaData
            }
            
        }).disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
        
        locationLabel.text = "Praha"
        navigationItem.title = "Počasí"
    }

    // MARK: Additional methods
    
    func handleLoadingUI(_ hide: Bool) {
        UIView.animate(withDuration: 0.23, animations: {
            self.temperatureLabel.isHidden = hide ? true : false
            self.temperatureLabel.alpha = hide ? 0 : 1
                 
            self.messageLabel.isHidden = hide ? true : false
            self.messageLabel.alpha = hide ? 0 : 1
        })
    }

}
