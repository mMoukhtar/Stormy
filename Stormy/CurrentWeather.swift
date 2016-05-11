//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Mohamed Moukhtar on 5/10/16.
//  Copyright © 2016 Mohamed Moukhtar. All rights reserved.
//

import Foundation


enum WeatherErrors: ErrorType {
    case InvalidData
}

//MARK: - Current Weather Struct

struct CurrentWeather {
    let temperature: Int
    let humidity: Double
    let precipProbability: Double
    let summary: String

    init (weatherDictionary: [String : AnyObject]) throws {
        guard let temperature = weatherDictionary["temperature"] as? Int,
        let humidity = weatherDictionary["humidity"] as? Double,
        let precipProbability = weatherDictionary["precipProbability"] as? Double,
        let summary = weatherDictionary["summary"] as? String else{
            throw WeatherErrors.InvalidData
        }
        self.temperature = temperature
        self.humidity = humidity
        self.precipProbability = precipProbability
        self.summary = summary
    }


}




/*

 <key>currently</key>
	<dict>
 <key>time</key>
 <date>2015-01-18T02:39:54Z</date>
 <key>summary</key>
 <string>Overcast</string>
 <key>icon</key>
 <string>cloudy</string>
 <key>precipIntensity</key>
 <integer>0</integer>
 <key>precipProbability</key>
 <real>0</real>
 <key>temperature</key>
 <integer>80</integer>
 <key>apparentTemperature</key>
 <integer>80</integer>
 <key>dewPoint</key>
 <real>-0.5600000000000001</real>
 <key>humidity</key>
 <real>0.93</real>
 <key>windSpeed</key>
 <real>5.43</real>
 <key>windBearing</key>
 <integer>277</integer>
 <key>cloudCover</key>
 <real>0.97</real>
 <key>pressure</key>
 <real>995.84</real>
 <key>ozone</key>
 <real>271.83</real>
	</dict>

 
 */
