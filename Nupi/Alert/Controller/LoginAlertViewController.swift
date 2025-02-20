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
        
        // 버튼 액션 연결
        loginAlertView.dismissButton.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
        loginAlertView.loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: action
    @objc private func dismissButtonDidTap() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func loginButtonDidTap() {
        print("로그인 버튼 클릭")
        self.dismiss(animated: false) { [weak self] in
            guard let presentingVC = self?.presentingViewController else { return }
            
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            presentingVC.present(loginVC, animated: true, completion: nil)
        }
    }
}
