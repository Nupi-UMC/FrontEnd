//
//  LoginViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var loginView:  LoginView = {
        let view = LoginView()
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonTap), for: .touchUpInside)
    }
    
    @objc
    private func signUpButtonTap(){
        let signUpVC = BeginSignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
