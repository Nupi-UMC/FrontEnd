//
//  LoginViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit
import Alamofire

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
        //둘러보기 버튼 동작
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
        fetchLogin()
        //self.coordinator?.showBaseViewController()
    }
    
    //회원가입 버튼 동작
    @objc
    private func signUpButtonTap(){
        let signUpVC = BeginSignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    //둘러보기 버튼 동작
    @objc private func browseButtonTap() {
        let homeVC = HomeViewController()
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    private func fetchLogin() {
        let parameters = LoginRequest(
            email: loginView.emailTextField.text ?? "",
            password: loginView.passwordTextField.text ?? ""
        )

        APIClient.postRequest(endpoint: "/api/auth/login", parameters: parameters) { (result: Result<LoginResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.isSuccess, let loginResult = response.result {
                    print("로그인 성공: \(response.message)")

                    // Access Token & Refresh Token을 Keychain에 저장
                    KeychainService.save(value: loginResult.accessToken, for: "accessToken")
                    KeychainService.save(value: loginResult.refreshToken, for: "refreshToken")
                    // 저장된 토큰 확인
                    if let savedAccessToken = KeychainService.load(for: "accessToken") {
                        print("저장된 Access Token: \(savedAccessToken)")
                    } else {
                        print("Access Token 저장 실패")
                    }

                    if let savedRefreshToken = KeychainService.load(for: "refreshToken") {
                        print("저장된 Refresh Token: \(savedRefreshToken)")
                    } else {
                        print("Refresh Token 저장 실패")
                    }

                    DispatchQueue.main.async {
                        // 메인 화면으로 이동
                        self.coordinator?.showBaseViewController()
                    }
                } else {
                    print(" 로그인 실패: \(response.message)")
                }
            case .failure(let error):
                print("API 호출 중 오류 발생: \(error.localizedDescription)")
            }
        }
    }
}
