//
//  TodayViewController.swift
//  DevStackToday
//
//  Created by Filip Bodnár on 13/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit
import CoreLocation
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, CLLocationManagerDelegate {
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!

    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateWidget()
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        updateWidget()
        completionHandler(NCUpdateResult.newData)
    }

    func updateWidget() {
        if currentLocation != nil {
            let latText = String(format: "Lat: %.4f", currentLocation!.coordinate.latitude)
            let lngText = String(format: "Lng: %.4f", currentLocation!.coordinate.longitude)

            latLabel.text = latText
            lngLabel.text = lngText
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}
