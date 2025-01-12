//
//  VerifyEmailViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit

class VerifyEmailViewController: UIViewController {
    
    private lazy var verifyEmailView: VerifyEmailView = {
        let view = VerifyEmailView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = verifyEmailView
        
        setupNavigationBar(action: #selector(customBackButtonTapped))
        verifyEmailView.emailVerifyButton.addTarget(self, action: #selector(verifyEmailButtonTap), for: .touchUpInside)
    }
    
    @objc private func verifyEmailButtonTap(){
        let createPasswordVC = CreatePasswordViewController()
        self.navigationController?.pushViewController(createPasswordVC, animated: true)
    }
}
