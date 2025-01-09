//
//  CreatePasswordViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    
    private lazy var createPasswordView: CreatePasswordView = {
        let view = CreatePasswordView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = createPasswordView
    }
}
