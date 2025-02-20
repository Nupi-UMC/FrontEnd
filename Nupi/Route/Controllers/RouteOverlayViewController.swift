//
//  RouteOverlayViewController.swift
//  Nupi
//
//  Created by narong on 1/28/25.
//

import UIKit

class RouteOverlayViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOverlayView()
        
    }

    private func setupOverlayView() {
        let overlayView = RouteOverlayView(frame: view.bounds)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        overlayView.backgroundColor = .clear
        view.addSubview(overlayView)

        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension RouteOverlayViewController: RouteOverlayViewDelegate {
    func didTapAddButton() {
        let createVC = CreateRouteViewController()
        createVC.modalPresentationStyle = .fullScreen
        self.present(createVC, animated: true, completion: nil)
        print("presented createVC modally")
    }
}
