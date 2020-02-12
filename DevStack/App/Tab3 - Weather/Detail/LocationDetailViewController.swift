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
    
    
    @IBOutlet weak var dayToday: UILabel!
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var day2temp: UILabel!
    @IBOutlet weak var day2icon: UIImageView!
    @IBOutlet weak var day3: UILabel!
    @IBOutlet weak var day3temp: UILabel!
    @IBOutlet weak var day3icon: UIImageView!
    @IBOutlet weak var day4: UILabel!
    @IBOutlet weak var day4temp: UILabel!
    @IBOutlet weak var day4icon: UIImageView!
    @IBOutlet weak var day5: UILabel!
    @IBOutlet weak var day5temp: UILabel!
    @IBOutlet weak var day5icon: UIImageView!
    @IBOutlet weak var day6: UILabel!
    @IBOutlet weak var day6temp: UILabel!
    @IBOutlet weak var day6icon: UIImageView!
    
    // MARK: Stored properties
    private var woeid: Int!
    private var locationName: String!
    
    private var forecast: [Clima?] = [] {
        didSet {
            if let currentTemp = forecast[0]?.theTemp,
                let message = forecast[0]?.weatherStateName,
                let applicableDate = forecast[0]?.applicableDate {
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
                        case 1:
                            self.day2.text = dayInWeek
                            self.day2temp.text = "\(temperature) °C"
                            self.day2icon.image = self.setIcon(iconName)
                        case 2:
                            self.day3.text = dayInWeek
                            self.day3temp.text = "\(temperature) °C"
                            self.day3icon.image = self.setIcon(iconName)
                        case 3:
                            self.day4.text = dayInWeek
                            self.day4temp.text = "\(temperature) °C"
                            self.day4icon.image = self.setIcon(iconName)
                        case 4:
                            self.day5.text = dayInWeek
                            self.day5temp.text = "\(temperature) °C"
                            self.day5icon.image = self.setIcon(iconName)
                        case 5:
                            self.day6.text = dayInWeek
                            self.day6temp.text = "\(temperature) °C"
                            self.day6icon.image = self.setIcon(iconName)
                        default:
                            self.dayToday.text = dayInWeek
                            temperatureLabel.text = "\(temperature) °C"
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
                self?.view.startActivityIndicator()
            } else if let climaData = event.data {
                self?.view.stopActivityIndicator()
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
        print("iconName", iconName)
        switch iconName {
            case "lc":
                return UIImage(named: "010-light-clouds")! // Assets TODO 
            case "hc": // Heavy cloud
                return UIImage(named: "009-heavy-clouds")!
            case "hr":
                return UIImage(named: "008-heavy-rain")!
            case "lr": // Light rain
                return UIImage(named: "004-rainy")!
            case "sn":
                return UIImage(named: "002-snow")!
            case "s": // Showers
                return UIImage(named: "006-drop")!
            case "c":
                return UIImage(named: "001-sunny")!
            default:
                return UIImage()
        }
    }
    
}
