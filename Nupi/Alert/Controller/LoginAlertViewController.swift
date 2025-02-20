//
//  LoginAlertViewController.swift
//  Nupi
//
//  Created by 신연주 on 2/20/25.
//

import UIKit

class LoginAlertViewController: UIViewController {
    
    private let loginAlertView = LoginAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginAlertView
    }
    
}
