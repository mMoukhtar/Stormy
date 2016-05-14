//
//  ViewController.swift
//  Stormy
//
//  Created by Mohamed Moukhtar on 5/10/16.
//  Copyright © 2016 Mohamed Moukhtar. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var lblCurrentTemperature: UILabel?
    @IBOutlet weak var lblCurrentHumedity: UILabel?
    @IBOutlet weak var lblCurrentRainPercent: UILabel?
    @IBOutlet weak var imgCurrentWeatherIcon: UIImageView?
    @IBOutlet weak var lblCurrentSummary: UILabel?
    @IBOutlet weak var lblCurrentLocation: UILabel?
    @IBOutlet weak var lblActivityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var btnRefresh: UIButton?
    
    // MARK: - Stored Properties
    
    var locationManager: CLLocationManager?
    private var currentLocation: Location?
    private let clMGR: CLLocationManager = CLLocationManager()
    private let forcastAPIKey = "f37f728992536a55e222320945d7d59a"
    
    
    // MARK: - View Initializing Methods
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // update Current Location
        updatingLocation()
    }
    // Change The Style of Status Bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK: - View Controllers Events
    
    @IBAction func btnRefreshTouchUpInside(sender: AnyObject) {
        btnRefresh?.hidden = true
        toggleActivityIndicator(toggleOff: false)
        updatingLocation()
    }
    
    //MARK: - Helper Methods
    
    func updatingLocation() {
        clMGR.delegate = self
        clMGR.requestWhenInUseAuthorization()
        clMGR.desiredAccuracy = kCLLocationAccuracyBest
        clMGR.startUpdatingLocation()
    }
    
    private func getViewValues(currentLocation location: String) {
        let forcastServices = ForcastServices(APIKey: forcastAPIKey)
        if let (lat, long) = currentLocation?.coordinates {
            forcastServices.getCurrentWeather(long, lat: lat) {
                (let currently) in
                if let currentWeather = currently {
                    // Return to main thread
                    dispatch_async(dispatch_get_main_queue()) {
                        print(currentWeather)
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
                        self.lblCurrentLocation?.text = location
                        self.toggleActivityIndicator(toggleOff: true)
                    }
                }
            }
        } else {
            toggleActivityIndicator(toggleOff: true)
            print("No Valid Coordinates")
        }
    }
    
    private func toggleActivityIndicator(toggleOff toggleOff: Bool) {
        lblActivityIndicator?.hidden = toggleOff
        btnRefresh?.hidden = !toggleOff
    }
    

    //MARK: - Core Location Manager Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        currentLocation = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print("Current Location \(currentLocation?.coordinates)")
        manager.stopUpdatingLocation()
        // Get Weather Forcast
        
        currentLocation?.getGeoLocationFromCoordinates(location, addressFileds: [Location.AddressField.subAdministrativeArea, Location.AddressField.administrativeArea]) { (address, error) in
            //Return to the main thread
            dispatch_async(dispatch_get_main_queue()) { 
                //Get Current View Values
                self.toggleActivityIndicator(toggleOff: false)
                self.getViewValues(currentLocation: address)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription)
        print(error.localizedFailureReason)
        print(error.localizedRecoveryOptions)
        print(error.localizedRecoverySuggestion)
        manager.stopUpdatingLocation()
        //No valid location
    }


}

















