//
//  LoginView.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit
import SnapKit

class LoginView : UIView {
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var AppLogoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일을 입력하세요"
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 2
        
        return textField
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력하세요"
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 2
        return textField
    }()
    
    private lazy var findPasswordButton : UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    private lazy var loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("이메일로 로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    lazy var signUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    
    private lazy var findEmailButton : UIButton = {
        let button = UIButton()
        button.setTitle("이메일 찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    
    private func addComponents(){
        self.addSubview(AppLogoImageView)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(findPasswordButton)
        self.addSubview(signUpButton)
        self.addSubview(findEmailButton)
        
        AppLogoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(265)
            make.centerX.equalToSuperview()
            make.width.equalTo(329)
            make.height.equalTo(37)
        }
        emailTextField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(330)
            make.centerX.equalToSuperview()
            make.width.equalTo(329)
            make.height.equalTo(47)
        }
        passwordTextField.snp.makeConstraints{ make in
            make.top.equalTo(emailTextField.snp.bottom).offset(9)
            make.centerX.equalToSuperview()
            make.width.equalTo(329)
            make.height.equalTo(47)
        }
        
        findPasswordButton.snp.makeConstraints{ make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(0)
            make.width.equalTo(72)
            make.height.equalTo(18)
            
        }
        loginButton.snp.makeConstraints {make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(329)
            make.height.equalTo(47)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(123)
        }
        findEmailButton.snp.makeConstraints { make in
            make.centerY.equalTo(signUpButton)
            make.trailing.equalToSuperview().inset(123)
        }
    }
}
