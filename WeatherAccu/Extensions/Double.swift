//
//  Double.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import Foundation

extension Double {
    func getKelvinToCelciusOrFarenheit(toCelcius: Bool) -> String {
        var convertedValue = ""
        if toCelcius {
            let valueInCelcius = self - 273.15
            convertedValue = "\(valueInCelcius.rounded(toPlaces: 1))\u{00B0}C"
        } else {
            let valueInFarenheit = (1.8 * (self - 273.15)) + 32
            convertedValue = "\(valueInFarenheit.rounded(toPlaces: 1))\u{00B0}F"
        }
        return convertedValue
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
