//
//  WeatherVC.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import Foundation
import UIKit

class WeatherVC: HostingVC<WeatherHomeView> {
    override init() {
        super.init()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func createSwiftUIView() -> WeatherHomeView {
        WeatherHomeView(viewModel: WeatherHomeViewModel())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
