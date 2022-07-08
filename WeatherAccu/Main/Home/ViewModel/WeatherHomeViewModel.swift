//
//  WeatherHomeViewModel.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import Foundation
import UIKit

class WeatherHomeViewModel: ObservableObject {
    weak var vc: UIViewController?
    @Published var isLoading = false
    var majorCities = [MajorCity]()
    @Published var majorCitiesWeatherData = [MajorCityWeatherData]()
    @Published var currentLocationWeatherData: MajorCityWeatherData?
    
    init() {
        LocationManager.shared.delegate = self
        // Provide the list of cities that has to be shown on the home screen.
        self.majorCities = [MajorCity(id: 0, name: "Gothenburg", coordinate: LocationCoordinate(latitude: 57.708870, longitude: 11.974560)),
                            MajorCity(id: 1, name: "Stockholm", coordinate: LocationCoordinate(latitude: 59.334591, longitude: 18.063240)),
                            MajorCity(id: 2, name: "Moutain View", coordinate: LocationCoordinate(latitude: 37.386051, longitude: -122.083855)),
                            MajorCity(id: 3, name: "London", coordinate: LocationCoordinate(latitude: 51.509865, longitude: -0.118092)),
                            MajorCity(id: 4, name: "New York", coordinate: LocationCoordinate(latitude: 40.730610, longitude: -73.935242)),
                            MajorCity(id: 5, name: "Berlin", coordinate: LocationCoordinate(latitude: 52.520008, longitude: 13.404954))]
    }
    
    // Gets the weather data for the given set of cities
    
    func loadWeatherData() {
        isLoading = true
        var weatherDataListOfMajorCities = [MajorCityWeatherData]()
        var currentCityWeatherDetails: MajorCityWeatherData?
        let group = DispatchGroup()
        
        if let currentLat = StorageDefaults.lastSavedLocation?.latitude, let currentLong = StorageDefaults.lastSavedLocation?.longitude {
            WeatherManager.getWeatherData(latitude: currentLat, longitude: currentLong) { response, err in
                if response != nil, let lat = response?.coord.lat, let long = response?.coord.lon {
                    let currentCityWeatherData = MajorCityWeatherData(id: self.majorCities.count + 1, name: response?.name ?? "", coordinate: LocationCoordinate(latitude: lat, longitude: long), weatherData: response)
                    currentCityWeatherDetails = currentCityWeatherData
                }
            }
        }
        
        // Iterate through majorCities list and fetch weather details of each one and save locally.
        for city in majorCities {
            group.enter()
            WeatherManager.getWeatherData(latitude: city.coordinate.latitude, longitude: city.coordinate.longitude) { response, err in
                if response != nil {
                    let cityWeatherData = MajorCityWeatherData(id: city.id, name: city.name, coordinate: city.coordinate, weatherData: response)
                    weatherDataListOfMajorCities.append(cityWeatherData)
                    do { group.leave() }
                }
                if err != nil {
                    do { group.leave() }
                }
            }
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
            // Update UI when we have weather data of all cities.
            DispatchQueue.main.async {
                self.majorCitiesWeatherData = weatherDataListOfMajorCities
                self.currentLocationWeatherData = currentCityWeatherDetails
            }
        }
    }
    
    // Gets weather data of current location
    func getCurrentWeatherData() {
        if let currentLat = StorageDefaults.lastSavedLocation?.latitude, let currentLong = StorageDefaults.lastSavedLocation?.longitude {
            WeatherManager.getWeatherData(latitude: currentLat, longitude: currentLong) { response, err in
                if response != nil, let lat = response?.coord.lat, let long = response?.coord.lon {
                    let currentCityWeatherData = MajorCityWeatherData(id: self.majorCities.count + 1, name: response?.name ?? "", coordinate: LocationCoordinate(latitude: lat, longitude: long), weatherData: response)
                    DispatchQueue.main.async {
                        self.currentLocationWeatherData = currentCityWeatherData
                    }
                }
            }
        }
    }
}

extension WeatherHomeViewModel: LocationManagerDelegate {
    // Gets triggered when user changes the authorization.
    func updateCurrentWeatherData() {
        getCurrentWeatherData()
    }
}
