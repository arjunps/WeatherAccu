//
//  LocationManager.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func updateCurrentWeatherData()
}

class LocationManager: NSObject {
    
    // Creating an instance of CLLocationManager
    private static var _shared: LocationManager?
    
    private var manager: CLLocationManager?
    weak var delegate: LocationManagerDelegate?
    
    static var shared: LocationManager {
        if _shared == nil {
            _shared = LocationManager()
        }

        return _shared!
    }

    override private init() {
        manager = CLLocationManager()
        manager?.activityType = .automotiveNavigation
        super.init()
        manager?.delegate = self
        manager?.requestWhenInUseAuthorization()
        manager?.startMonitoringSignificantLocationChanges()
    }
    
    // Requests the one-time delivery of the user’s current location
    func requestLocation() {
        manager?.requestLocation()
    }

}

// Location manager delegate functions
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Save last saved location to Userdefaults
        StorageDefaults.lastSavedLocation = LocationCoordinate(latitude: locations.first?.coordinate.latitude ?? 0.0, longitude: locations.first?.coordinate.longitude ?? 0.0)
        self.delegate?.updateCurrentWeatherData()

    }
}
