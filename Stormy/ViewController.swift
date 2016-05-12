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
    
    private let forcastAPIKey = "f37f728992536a55e222320945d7d59a"
    private let coordinates: (Lat: Double, Long: Double) = (37.8267,-122.423)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get Weather Forcast
        let forcastServices = ForcastServices(APIKey: forcastAPIKey)
        forcastServices.getCurrentWeather(coordinates.Long, lat: coordinates.Lat) {
            (let currently) in
            if let currentWeather = currently {
                // Return to main thread
                dispatch_async(dispatch_get_main_queue(), { 
                    if let temperature = currentWeather.temperature {
                        self.lblCurrentTemperature?.text = "\(temperature)º"
                    }
                    if let humedity = currentWeather.humidity {
                        self.lblCurrentHumedity?.text = "\(humedity)%"
                    }
                    if let precipProbability = currentWeather.precipProbability {
                        self.lblCurrentRainPercent?.text = "\(precipProbability)%"
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
