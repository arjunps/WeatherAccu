//
//  HomeModels.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import Foundation

struct MajorCity: Codable {
    let name: String
    let coordinate: LocationCoordinate
}

struct MajorCityWeatherData: Codable, Identifiable {
    let id = UUID()
    let name: String
    let coordinate: LocationCoordinate
    let weatherData: WeatherResponseBody?
}

struct LocationCoordinate: Codable {
    let latitude: Double
    let longitude: Double
}

// Model of the response body we get from calling the OpenWeather API
struct WeatherResponseBody: Codable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
}

struct CoordinatesResponse: Codable {
    var lon: Double
    var lat: Double
}

struct WeatherResponse: Codable {
    var id: Double
    var main: String
    var description: String
    var icon: String
}

struct MainResponse: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
}

struct WindResponse: Codable {
    var speed: Double
    var deg: Double
}

extension MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
