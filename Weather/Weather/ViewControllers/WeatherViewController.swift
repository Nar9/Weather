//
//  WeatherViewController.swift
//  Weather
//
//  Created by Narine Balasanyan on 11/3/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import UIKit
import CoreLocation
import MBProgressHUD

class WeatherViewController: UIViewController {
    
    // MARK: - Interface builder outlets
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // MARK: - Properties
    
    private var locationManager: CLLocationManager!
    private var isLocationUpdated = false
    private var weather: WeatherData?
    
    var country: Countries.Country?
    
    // MARK: - View initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let country = country {
            getWeatherWithCoordinates(lat: country.coordinates.lat, lon: country.coordinates.lon)
            self.country = nil
        }
    }
    
    // MARK: - Methods
    
    private func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func getWeatherWithCoordinates(lat: Double, lon: Double) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ApiManager().getWeatherWithCoordinates(lat: lat, lon: lon) { (isSuccess, weatherData, errorMessage) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            if isSuccess, let weatherData = weatherData {
                self.weather = weatherData
                self.updateUI()
            } else {
                self.showAlert(withMessage: "", andTitle: errorMessage!)
            }
        }
    }
    
    private func updateUI() {
        guard let weather = weather else {
            return
        }
        countryLabel.text = weather.city
        descriptionLabel.text = weather.description
        temperatureLabel.text = formatTemperatureText(temp: weather.temperature)
        let urlString = "\(ApiUrls.iconUrl)\(weather.iconName)@2x.png"
        weatherIconImageView.image(withURL: urlString)
    }
    
    private func formatTemperatureText(temp: Double) -> String {
        return String(format: "%.0f℃", temp)
    }
}

// MARK: - CLLocationManagerDelegate methods

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !isLocationUpdated {
            let userLocation: CLLocation = locations[0] as CLLocation
            isLocationUpdated = true
            locationManager.stopUpdatingLocation()
            getWeatherWithCoordinates(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(withMessage: "", andTitle: ErrorMessages.defaultErrorTitle)
    }
}
