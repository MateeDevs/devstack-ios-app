// 
//  LocationDetailViewController.swift
//  DevStack
//
//  Created by Filip Bodnár on 12/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit
import RxSwift

protocol LocationDetailFlowDelegate: class {

}

final class LocationDetailViewController: BaseViewController {

    // MARK: FlowDelegate
    weak var flowDelegate: LocationDetailFlowDelegate?

    // MARK: ViewModels
    private var viewModel: LocationDetailViewModel!

    // MARK: UI components
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var forecastDay1: DesignableXibView!
    @IBOutlet weak var forecastDay2: DesignableXibView!
    @IBOutlet weak var forecastDay3: DesignableXibView!
    @IBOutlet weak var forecastDay4: DesignableXibView!
    @IBOutlet weak var forecastDay5: DesignableXibView!
    
    @IBOutlet weak var dayToday: UILabel!
    
    // MARK: Stored properties
    private var woeid: Int!
    private var locationName: String!
    
    private var forecast: [Clima?] = [] {
        didSet {
            if let currentTemp = forecast[0]?.theTemp,
                let message = forecast[0]?.weatherStateName {
                weatherStateLabel.text = message
                temperatureLabel.text = "\(currentTemp.rounded()) °C"
            }
            
            for var (index, item) in forecast.enumerated() {
                if let strDate = item?.applicableDate, let temperature = item?.theTemp.rounded(), let iconName = item?.weatherStateAbbr {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from: strDate)
                    if let foo = date {
                        dateFormatter.dateFormat = "EEEE"
                        let dayInWeek = dateFormatter.string(from: foo)
                        
                        switch index {
                        case 0:
                            self.dayToday.text = dayInWeek
                            temperatureLabel.text = "\(temperature) °C"
                        case 1:
                            forecastDay1.image.image = self.setIcon(iconName)
                            forecastDay1.tempLabel.text = "\(temperature) °C"
                            forecastDay1.dayLabel.text = dayInWeek
                        case 2:
                            forecastDay2.image.image = self.setIcon(iconName)
                            forecastDay2.tempLabel.text = "\(temperature) °C"
                            forecastDay2.dayLabel.text = dayInWeek
                        case 3:
                            forecastDay3.image.image = self.setIcon(iconName)
                            forecastDay3.tempLabel.text = "\(temperature) °C"
                            forecastDay3.dayLabel.text = dayInWeek
                        case 4:
                            forecastDay4.image.image = self.setIcon(iconName)
                            forecastDay4.tempLabel.text = "\(temperature) °C"
                            forecastDay4.dayLabel.text = dayInWeek
                        case 5:
                            forecastDay5.image.image = self.setIcon(iconName)
                            forecastDay5.tempLabel.text = "\(temperature) °C"
                            forecastDay5.dayLabel.text = dayInWeek
                        default:
                           return
                        }
                    }
                }
            }
        }
    }

    // MARK: Inits
    static func instantiate(viewModel: LocationDetailViewModel, woeid: Int, locationName: String) -> LocationDetailViewController {
        let vc = StoryboardScene.LocationDetail.initialScene.instantiate()
        vc.viewModel = viewModel
        vc.woeid = woeid
        vc.locationName = locationName

        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()
        
        let input = LocationDetailViewModel.Input(woeid: self.woeid)
        let output = viewModel.transform(input: input)
        output.getClimaByWOEID.drive(onNext: { [weak self] event in
            if event.isLoading {
                self?.handleLoadingUI(true)
                self?.view.startActivityIndicator()
            } else if let climaData = event.data {
                self?.view.stopActivityIndicator()
                self?.handleLoadingUI(false)
                self?.forecast = climaData
            }
        }).disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
        
        self.title = locationName
        self.locationLabel.text = locationName
    }

    // MARK: Additional methods
    fileprivate func setIcon(_ iconName: String) -> UIImage {
        switch iconName {
            case "lc":
                return Asset.Images._010LightClouds.image
            case "hc": // Heavy cloud
                return Asset.Images._009HeavyClouds.image
            case "hr":
                return Asset.Images._008HeavyRain.image
            case "lr": // Light rain
                return Asset.Images._004Rainy.image
            case "sn":
                return Asset.Images._002Snow.image
            case "s": // Showers
                return Asset.Images._006Drop.image
            case "c":
                return Asset.Images._001Sunny.image
            default:
                return UIImage()
        }
    }
    
    fileprivate func handleLoadingUI(_ shouldHide: Bool) {
        for element in self.view.subviews {
            UIView.animate(withDuration: 0.23, animations: {
                element.isHidden = shouldHide ? true : false
                element.alpha = shouldHide ? 0 : 1
            })
        }
    }
}
