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
    static func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherResponseBody? {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=81c597afe02bfd7efe78456f6ef75eae") else { return nil }


        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decodedData = try JSONDecoder().decode(WeatherResponseBody.self, from: data)
        
        return decodedData
    }
    
    static func getWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (WeatherResponseBody?, Error?) -> Void) {
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
