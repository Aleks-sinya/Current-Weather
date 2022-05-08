//
//  ViewController.swift
//  Current Weather
//
//  Created by Алексей Синяговский on 08.05.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var weatherTemperatureLabel: UILabel!
    @IBOutlet var weatherIconImage: UIImageView!
    
    let locationManager = CLLocationManager()
    var weatherData = WeatherData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLocationManager()
    }
    
    private func updateView() {
        cityNameLabel.text = weatherData.name
        weatherDescriptionLabel.text = DataSource.weatherIDs[weatherData.weather[0].id]
        weatherTemperatureLabel.text = weatherData.main.temp.description + "°C"
        weatherIconImage.image = UIImage(named: weatherData.weather[0].icon)
    }
    
    func updateWeatherInfo(latitude: Double, longitude: Double) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longitude.description)&APPID=febfa7d2ab388755070a4cd282675ed4&lang=ru&units=metric") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                print(self.weatherData)
                DispatchQueue.main.async {
                    self.updateView()
                }
            } catch let error {
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
    
    
    
    private func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        }
    }
}

