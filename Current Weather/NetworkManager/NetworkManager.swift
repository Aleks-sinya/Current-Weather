//
//  NetworkManager.swift
//  Current Weather
//
//  Created by Алексей Синяговский on 08.05.2022.
//

import Foundation
/*
class NetworkManager {
    
    var weatherData = WeatherData()

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
 */
