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
        self.backgroundColor = .bg
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var browseButton : UIButton = {
        let button = UIButton()
        button.setTitle("둘러보기", for: .normal)
        button.titleLabel?.font = .caption1
        button.setTitleColor(.icon1, for: .normal)
        button.backgroundColor = .clear
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 15, weight: .light)
        let browseImage = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        button.setImage(browseImage, for: .normal)
        
        button.tintColor = .icon1
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5) // 텍스트와 이미지 간격 설정
        return button
    }()
    
    private lazy var AppLogoLabel : UILabel = {
        let label = UILabel()
        label.text = "NUPI"
        label.font = .logo2
        label.textColor = .blue2
        return label
    }()
    
    private lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "이메일을 입력하세요",
            attributes: [
                .font: UIFont.button3,
                NSAttributedString.Key.foregroundColor: UIColor.icon2
            ]
        )
        textField.font = .body2
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.blue1.cgColor
        textField.layer.backgroundColor = UIColor.white2.cgColor
        textField.textColor = .icon1
        return textField
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "비밀번호를 입력하세요",
            attributes: [
                .font: UIFont.button3,
                NSAttributedString.Key.foregroundColor: UIColor.icon2

            ]
        )
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.blue1.cgColor
        textField.layer.backgroundColor = UIColor.white2.cgColor
        textField.textColor = .icon1
        return textField
    }()
    
    private lazy var findPasswordButton : UIButton = {
        let button = UIButton()
        let attributedTitle = NSAttributedString(
            string: "비밀번호 찾기",
            attributes: [
                .font: UIFont.caption2,
                .foregroundColor: UIColor.icon2,
                .underlineStyle: NSUnderlineStyle.single.rawValue,  // 밑줄
                .baselineOffset: 5
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    private lazy var loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("이메일로 로그인", for: .normal)
        button.titleLabel?.font = .heading2
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue3
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    lazy var signUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.icon1, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.caption2
        return button
    }()
    
    private lazy var dividelineView : UIView = {
        let view = UIView()
        view.backgroundColor = .blue1
        return view
    }()
    
    private lazy var findEmailButton : UIButton = {
        let button = UIButton()
        button.setTitle("이메일 찾기", for: .normal)
        button.setTitleColor(.icon1, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.caption2

        return button
    }()
    
    
    private func addComponents(){
        self.addSubview(browseButton)
        self.addSubview(AppLogoLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(findPasswordButton)
        self.addSubview(signUpButton)
        self.addSubview(dividelineView)
        self.addSubview(findEmailButton)
        
        browseButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.trailing.equalToSuperview().inset(35)
            make.height.equalTo(19)
        }
        
        AppLogoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(265)
            make.centerX.equalToSuperview()
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
        
        dividelineView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(18)
            make.centerY.equalTo(signUpButton)
            make.centerX.equalTo(signUpButton.snp.trailing).offset(20)
        }
    }
}
