//
//  BeginSignUpViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit

class BeginSignUpViewController: UIViewController {
    
    private lazy var beginSignUpView: BeginSignUpView = {
        let view = BeginSignUpView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = beginSignUpView
    }
    
    private func continueButtonTap(){
        let emailVerifyVC = VerifyEmailViewController()
        self.navigationController?.pushViewController(emailVerifyVC, animated: true)
    }
}
