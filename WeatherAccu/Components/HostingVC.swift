//
//  HostingVC.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//
import SnapKit
import SwiftUI

class HostingVC<Content: View>: UIViewController {
    init() {
    
        super.init(nibName: nil, bundle: nil)

        let rootView = createSwiftUIView()
        let host = UIHostingController(rootView: rootView)
        addChild(host)
        view.addSubview(host.view)
        host.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        print("INIT HostingVC")
    }

    deinit {
        print("DEINIT HostingVC")
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func createSwiftUIView() -> Content {
        fatalError("Must override in subclass")
    }
}

