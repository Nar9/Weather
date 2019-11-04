//
//  ApiManager.swift
//  Weather
//
//  Created by Narine Balasanyan on 11/3/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    
    public func getWeatherWithCoordinates(lat: Double, lon: Double, completion: @escaping (_ isSuccess: Bool, _ weatherData: WeatherData?, _ errorMessage: String?) -> Void) {
        Alamofire.request(ApiRouter.getWeatherWithCoordinates(lat: lat, lon: lon)).responseJSON { response in
            if let result = response.result.value as? [String : Any] {
                let weather = WeatherData(withData: result)
                completion(true, weather, nil)
            } else {
                completion(false, nil, ErrorMessages.defaultErrorTitle)
            }
        }
    }
}
