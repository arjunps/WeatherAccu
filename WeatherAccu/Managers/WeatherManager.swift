//
//  WeatherManager.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import CoreLocation
import Foundation

class WeatherManager {
    // HTTP request to get the current weather depending on the coordinates we got from LocationManager
    static func getWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (WeatherResponseBody?, Error?) -> Void) {
        
        // API key should be added from a config.
        let urlRequest = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=81c597afe02bfd7efe78456f6ef75eae")!

        var request = URLRequest(url: urlRequest)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let weatherData = try? JSONDecoder().decode(WeatherResponseBody.self, from: data) {
                    print(weatherData)
                    completion(weatherData, nil)
                } else {
                    completion(nil, error)
                    print("Invalid Response")
                }
            } else if let error = error {
                completion(nil, error)
                print("HTTP Request Failed \(error)")
            }
        }.resume()

        return completion(nil, nil)
    }
}
