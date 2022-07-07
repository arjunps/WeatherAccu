//
//  StoryboardInstantiable.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}

protocol StoryboardInstantiable {
    static var storyboardType: Storyboard { get }
}

extension StoryboardInstantiable where Self: UIViewController {
    static func instantiate() -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: nil)

        return storyboard.instantiateViewController(withIdentifier: String(describing: self))
    }
}
