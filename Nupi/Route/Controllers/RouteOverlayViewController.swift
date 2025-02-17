//
//  RouteOverlayViewController.swift
//  Nupi
//
//  Created by narong on 1/28/25.
//

import UIKit

class RouteOverlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = false
        setupOverlayView()
    }

    private func setupOverlayView() {
        let overlayView = RouteOverlayView(frame: view.bounds)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)

        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}


