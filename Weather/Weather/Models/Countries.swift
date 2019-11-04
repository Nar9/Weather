//
//  Countries.swift
//  Weather
//
//  Created by Narine Balasanyan on 11/3/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import Foundation

struct Countries: Codable {
    
    struct Country: Codable {
        var id: Int
        var city: String
        var country: String
        var coordinates: Coordinates
        
        struct Coordinates: Codable {
            var lat: Double
            var lon: Double
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case city = "name"
            case country
            case coordinates = "coord"
        }
    }
    var countries: [Country]
}
