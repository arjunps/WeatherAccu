//
//  StorageDefaults.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 08/07/22.
//

import Foundation

enum StorageKey: String, CaseIterable {
    case lastSavedLocation
    
    var name: String {
        rawValue
    }
}

enum StorageDefaults {
    static var lastSavedLocation: LocationCoordinate? {
        get {
            UserDefaults.standard.codable(forKey: StorageKey.lastSavedLocation.name)
        }
        set {
            UserDefaults.standard.set(value: newValue, forKey: StorageKey.lastSavedLocation.name)
        }
    }
}
