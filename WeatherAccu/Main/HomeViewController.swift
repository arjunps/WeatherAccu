//
//  HomeViewController.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import UIKit

class HomeNavigationViewController: UINavigationController, StoryboardInstantiable {
    static var storyboardType: Storyboard = .main
}

class HomeViewController: UIViewController {
    let homeVC = WeatherVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHomeVC()
    }

    private func addHomeVC() {
        addChild(homeVC)
        homeVC.view.frame = view.bounds
        view.addSubview(homeVC.view)
        homeVC.didMove(toParent: self)
    }
}

extension HomeViewController: StoryboardInstantiable {
    static var storyboardType: Storyboard = .main
}
