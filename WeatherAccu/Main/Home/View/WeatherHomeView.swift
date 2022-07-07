//
//  WeatherHomeView.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import SwiftUI

struct WeatherHomeView: View {
    @ObservedObject var viewModel: WeatherHomeViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                CustomLoadingView()
            } else {
                ScrollView(showsIndicators: false) {
                    // Show if current location weather data is available.
                    ForEach(viewModel.majorCitiesWeatherData, id: \.id) { city in
                        CityWeatherCardView(name: city.name,
                                            temp: city.weatherData?.main.temp,
                                            tempLow: city.weatherData?.main.tempMin,
                                            tempHigh: city.weatherData?.main.tempMax,
                                            climate: city.weatherData?.weather.first?.description,
                                            icon: city.weatherData?.weather.first?.icon)
                    }
                    
                    // Show major cities weather data
                    if let cuurentCityWeatherData = viewModel.currentLocationWeatherData {
                        CurrentLocationWeatherView(name: cuurentCityWeatherData.name,
                                                   temp: cuurentCityWeatherData.weatherData?.main.temp,
                                                   tempLow: cuurentCityWeatherData.weatherData?.main.tempMin,
                                                   tempHigh: cuurentCityWeatherData.weatherData?.main.tempMax,
                                                   climate: cuurentCityWeatherData.weatherData?.weather.first?.description,
                                                   icon: cuurentCityWeatherData.weatherData?.weather.first?.icon)
                    }
                    
                }
                .padding()
            }
        }
        .onAppear(perform: viewModel.loadWeatherData)
        .background(Color.gray.opacity(0.1))
    }
}

fileprivate struct CityWeatherCardView: View {
    let name: String
    let temp: Double?
    let tempLow: Double?
    let tempHigh: Double?
    let climate: String?
    let icon: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                        .fixedSize(horizontal: false, vertical: true)
                    if let tempConverted = temp?.getKelvinToCelciusOrFarenheit(toCelcius: true) {
                        Text("\(tempConverted)")
                            .font(.largeTitle)
                            .fontWeight(.light)
                            .foregroundColor(Color.black)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    if let tempConvertedLow = tempLow?.getKelvinToCelciusOrFarenheit(toCelcius: true), let tempConvertedHigh = tempHigh?.getKelvinToCelciusOrFarenheit(toCelcius: true) {
                        Text("H:\(tempConvertedHigh) / L:\(tempConvertedLow)")
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                Spacer()
                VStack(alignment: .trailing) {
                    if let icon = icon, let url =  URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png") {
                        AsyncImage(url: url) {
                            CustomLoadingView()
                        }
                        .frame(width: 64, height: 64, alignment: .center)
                    }
                    if let climateDesc = climate {
                        Text(climateDesc.uppercased())
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .padding()
        .background(
            Rectangle()
                .fill(Color.white)
                .cornerRadius(12)
                .shadow(
                    color: Color.gray.opacity(0.3),
                    radius: 3,
                    x: 0,
                    y: 0
                ))
    }
}

fileprivate struct CurrentLocationWeatherView: View {
    let name: String
    let temp: Double?
    let tempLow: Double?
    let tempHigh: Double?
    let climate: String?
    let icon: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Current Location")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .fixedSize(horizontal: false, vertical: true)
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .fixedSize(horizontal: false, vertical: true)
                    if let tempConverted = temp?.getKelvinToCelciusOrFarenheit(toCelcius: true) {
                        Text("\(tempConverted)")
                            .font(.largeTitle)
                            .fontWeight(.light)
                            .foregroundColor(Color.white)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    if let tempConvertedLow = tempLow?.getKelvinToCelciusOrFarenheit(toCelcius: true), let tempConvertedHigh = tempHigh?.getKelvinToCelciusOrFarenheit(toCelcius: true) {
                        Text("H:\(tempConvertedHigh) / L:\(tempConvertedLow)")
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                Spacer()
                VStack(alignment: .trailing) {
                    if let icon = icon, let url =  URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png") {
                        AsyncImage(url: url) {
                            CustomLoadingView()
                        }
                        .frame(width: 64, height: 64, alignment: .center)
                    }
                    if let climateDesc = climate {
                        Text(climateDesc.uppercased())
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .padding()
        .background(
            Rectangle()
                .fill(Color(hex: "255F85"))
                .cornerRadius(12)
                .shadow(
                    color: Color.gray.opacity(0.3),
                    radius: 3,
                    x: 0,
                    y: 0
                ))
    }
}
