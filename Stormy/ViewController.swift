//
//  ViewController.swift
//  Stormy
//
//  Created by Mohamed Moukhtar on 5/10/16.
//  Copyright © 2016 Mohamed Moukhtar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblCurrentTemperature: UILabel?
    @IBOutlet weak var lblCurrentHumedity: UILabel?
    @IBOutlet weak var lblCurrentRainPercent: UILabel?
    @IBOutlet weak var imgCurrentWeatherIcon: UIImageView?
    @IBOutlet weak var lblCurrentSummary: UILabel?
    @IBOutlet weak var lblCurrentLocation: UILabel?
    
    private let forcastAPIKey = "f37f728992536a55e222320945d7d59a"
    private let coordinates: (Lat: Double, Long: Double) = (37.8267,-122.423)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get Weather Forcast
        resetViewValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - View Controllers Events
    @IBAction func btnRefreshTouchUpInside(sender: AnyObject) {
        resetViewValues()
    }
    
    //MARK: - Helper Methods
    private func resetViewValues() {
        let forcastServices = ForcastServices(APIKey: forcastAPIKey)
        forcastServices.getCurrentWeather(coordinates.Long, lat: coordinates.Lat) {
            (let currently) in
            if let currentWeather = currently {
                // Return to main thread
                dispatch_async(dispatch_get_main_queue()) {
                    if let temperature = currentWeather.temperature {
                        self.lblCurrentTemperature?.text = "\(temperature)º"
                    }
                    if let humedity = currentWeather.humidity {
                        self.lblCurrentHumedity?.text = "\(humedity)%"
                    }
                    if let precipProbability = currentWeather.precipProbability {
                        self.lblCurrentRainPercent?.text = "\(precipProbability)%"
                    }
                    if let iconImage = currentWeather.icon {
                        self.imgCurrentWeatherIcon?.image = iconImage
                    }
                    if let summary = currentWeather.summary {
                        self.lblCurrentSummary?.text = summary
                    }
                    self.lblCurrentLocation?.text = "Current Location"
                }
            }
        }
    }

}
