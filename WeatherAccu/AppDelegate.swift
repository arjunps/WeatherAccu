//
//  AppDelegate.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        LocationManager.shared.requestLocation()
        setRootViewController()
        return true
    }
    
    func setRootViewController() {
        window?.rootViewController = HomeNavigationViewController.instantiate()
        window?.makeKeyAndVisible()
    }
}

