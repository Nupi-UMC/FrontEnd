//
//  AlertViewController.swift
//  Nupi
//
//  Created by 선가연 on 1/24/25.
//

import UIKit

class AlertViewController: UIViewController {

    private let alertView = AlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = alertView
    }

}
