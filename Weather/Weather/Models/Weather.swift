//
//  Weather.swift
//  Weather
//
//  Created by Narine Balasanyan on 11/3/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import Foundation

struct WeatherData {
    
    var city = ""
    var description = ""
    var iconName = ""
    var temperature = 0.0
    
    init(withData data: [String : Any]) {
        self.city = data["name"] as? String ?? ""
        if let weather = data["weather"] as? [[String : Any]], weather.count > 0 {
            self.description = weather[0]["main"] as? String ?? ""
            self.iconName = weather[0]["icon"] as? String ?? ""
        }
        if let main = data["main"] as? [String : Any] {
            let temperatureInKelvin = main["temp"] as? Double ?? 0.0
            let temperatureInCelsius = temperatureInKelvin - 273.15
            self.temperature = temperatureInCelsius
        }
    }
}
