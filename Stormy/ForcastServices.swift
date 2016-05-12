//
//  ForcastServices.swift
//  Stormy
//
//  Created by Mohamed Moukhtar on 5/12/16.
//  Copyright © 2016 Mohamed Moukhtar. All rights reserved.
//

import Foundation


struct ForcastServices {
    
    let forcastAPIKey: String
    let baseForcastURL: NSURL?
    
    init(APIKey: String) {
        forcastAPIKey = APIKey
        baseForcastURL = NSURL(string: "https://api.forecast.io/forecast/\(forcastAPIKey)/")
    }
    
    
    func getCurrentWeather(long: Double, lat: Double, completion: (CurrentWeather?) -> Void) {
        
        //Attemp to construct request for forcasting request
        if let baseURL = baseForcastURL, let forcastURL = NSURL(string: "\(lat),\(long)", relativeToURL: baseURL) {
            // Create a new network operations object
            let netwrorkOperation = NetworkOperations(url: forcastURL)
            //download JSON data
            netwrorkOperation.downloadJsonFromURL{ (let jsonDictionary) in
                let currentWeather = self.currentWeatherFromJson(jsonDictionary)
                completion(currentWeather)
            }
        } else {
            // Can't construct the URL
        }
    }
    
    
    func currentWeatherFromJson(jsonDictionary: [String: AnyObject]?) -> CurrentWeather? {
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        } else {
            // No valid currently dictionary
            return nil
        }
    }
}



//
//if let weatherDictionary = weatherForcastDictionary, let currentWeatherDictionary = weatherDictionary["currently"] {
//    
//} else {
//    // No valid currently dictionary
//}













