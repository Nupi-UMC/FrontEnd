//
//  CompleteSignUpViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit

class CompleteSignUpViewController: UIViewController {
    
    private lazy var completeSignUpView: CompleteSignUpView = {
        let view = CompleteSignUpView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = completeSignUpView
    }
}
