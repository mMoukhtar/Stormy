//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Mohamed Moukhtar on 5/10/16.
//  Copyright © 2016 Mohamed Moukhtar. All rights reserved.
//

import Foundation
import UIKit

enum WeatherErrors: ErrorType {
    case InvalidData
}

enum Icon: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    
    
    func weatherImageFromIconString () -> UIImage? {
        let imageName: String
            switch self {
            case .ClearDay:
                imageName = "clear-day.png"
            case .ClearNight:
                imageName = "clear-night.png"
            case .Rain:
                imageName = "rain.png"
            case .Snow:
                imageName = "snow.png"
            case .Sleet:
                imageName = "sleet.png"
            case .Wind:
                imageName = "wind.png"
            case .Fog:
                imageName = "fog.png"
            case .Cloudy:
                imageName = "cloudy.png"
            case .PartlyCloudyDay:
                imageName = "cloudy-day.png"
            case .PartlyCloudyNight:
                imageName = "cloudy-night.png"
            }
        return UIImage(named: imageName)
    }
}

//MARK: - Current Weather Struct

struct CurrentWeather {
    
    
    let temperature: Int?
    let humidity: Double?
    let precipProbability: Double?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    
    
    init (weatherDictionary: [String : AnyObject]) {
        if let temperature = weatherDictionary["temperature"] as? Double {
            self.temperature = Int((temperature - 32.0)/1.8)
        } else {
            self.temperature = nil
        }
        
        if let humidity = weatherDictionary["humidity"] as? Double {
            self.humidity = humidity * 100
        } else {
            self.humidity = nil
        }
        
        if let precipProbability = weatherDictionary["precipProbability"] as? Double {
            self.precipProbability = precipProbability * 100
        } else {
            self.precipProbability = nil
        }
        
        if let summary = weatherDictionary["summary"] as? String {
            self.summary = summary
        } else {
            self.summary = nil
        }
        
        if let iconString = weatherDictionary["icon"] as? String, let weatherIcon: Icon = Icon(rawValue: iconString) {
            self.icon = weatherIcon.weatherImageFromIconString()
        } else {
            self.icon = UIImage(named: "default.png")
        }
    }
}






















