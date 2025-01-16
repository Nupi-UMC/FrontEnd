//
//  LoginViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit

class LoginViewController: UIViewController {

    var coordinator: MainCoordinator?
    
    private lazy var loginView:  LoginView = {
        let view = LoginView()
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonTap), for: .touchUpInside)
        loginView.browseButton.addTarget(self, action: #selector(browseButtonTap), for: .touchUpInside)
        // 비밀번호 입력값 변경 감지
        loginView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        // hidePasswordButton 동작 추가
        loginView.hidePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        }
    
    var password : String = ""
    //유효성검사를 위한 property
    var isValidPassword = false


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
    
    //비밀번호 확인
    private func validatePasswordInfo(){
        let passwordText = loginView.passwordTextField.text ?? ""
        
        //유효성 검사 결과 업데이트 (조건 넣어줘야함)
        isValidPassword = true

        //유효성 검사 통과시, 변수에 값 할당
        if isValidPassword {
            password = passwordText
        }
        //에러 메세지 업데이트
        errorUpdateUI(for: loginView.passwordTextField, errorLabel: loginView.passwordErrorLabel, message: "비밀번호가 일치하지 않아요.", isValid: isValidPassword)
    }
    
    //로그인 버튼 동작
    @objc
    private func loginButtonTap(){
        validatePasswordInfo()
        coordinator?.showBaseViewController()
    }
    
    //회원가입 버튼 동작
    @objc
    private func signUpButtonTap(){
        let signUpVC = BeginSignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    /// 둘러보기 버튼 동작
    @objc private func browseButtonTap() {
        let tabBarVC = BaseViewController()
        self.navigationController?.setViewControllers([tabBarVC], animated: true)
    }
}
