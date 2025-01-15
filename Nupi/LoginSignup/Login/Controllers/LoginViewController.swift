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
        // 비밀번호 입력값 변경 감지
        loginView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        // hidePasswordButton 동작 추가
        loginView.hidePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        }


    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
    // 비밀번호 입력값이 없으면 버튼 숨기기
        loginView.hidePasswordButton.isHidden = textField.text?.isEmpty ?? true
    }

    @objc private func togglePasswordVisibility() {
        // 비밀번호 보이기/숨기기 토글
        loginView.passwordTextField.isSecureTextEntry.toggle()
    
        // 버튼 이미지 변경
        let imageName = loginView.passwordTextField.isSecureTextEntry ? "eye_slash" : "eye"
        loginView.hidePasswordButton.setImage(UIImage(named: imageName), for: .normal)
}
    
    //회원가입 버튼 동작
    @objc
    private func signUpButtonTap(){
        let signUpVC = BeginSignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
