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
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Stored properties
    var locationDict: [String : Int] = [
        "Vienna": 551801,
        "Minsk": 834463,
        "Brussels": 968019,
        "Sofia": 839722,
        "Zagreb": 851128,
        "Prague": 796597,
        "Copenhagen": 554890,
        "Paris": 615702,
        "Berlin": 638242,
        "Athens": 946738,
        "Budapest": 804365,
        "Dublin": 560743,
        "Rome": 721943,
        "London": 44418
    ]

    // MARK: Initss
    static func instantiate(viewModel: WeatherViewModel) -> WeatherViewController {
        let vc = StoryboardScene.Weather.initialScene.instantiate()
        vc.viewModel = viewModel
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    // MARK: Default methods
    override func setupViewModel() {
        super.setupViewModel()
        
    }

    override func setupUI() {
        super.setupUI()
                
        navigationItem.title = "Počasí"
    }

    // MARK: Additional methods
}


extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationDict.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! ForecastTableViewCell
        let locationKeys = Array(locationDict.keys)[indexPath.row]
        
        cell.setupCell(locationKeys)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationValues = Array(locationDict.values)[indexPath.row]
        let locationKeys = Array(locationDict.keys)[indexPath.row]
        flowDelegate?.showLocationDetail(woeid: locationValues, locationName: locationKeys)
    }
}
