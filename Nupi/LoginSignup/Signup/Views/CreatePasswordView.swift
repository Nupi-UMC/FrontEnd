//
//  CreatePasswordView.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit
import SnapKit

class CreatePasswordView : UIView {
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호 입력"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "영문, 숫자 조합"
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.backgroundColor = UIColor.clear.cgColor
        return textField
    }()
    
    private lazy var line1 : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var confirmPasswordLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left

        return label
    }()
    
    private lazy var confirmPasswordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "다시 한번 입력해주세요."
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.backgroundColor = UIColor.clear.cgColor
        return textField
    }()
    
    private lazy var line2 : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var continueLabel : UILabel = {
        let label = UILabel()
        label.text = "다음이 마지막 단계에요."
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var continueButton : UIButton = {
        let button = UIButton()
        button.setTitle("계속하기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    private func addComponents(){
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(confirmPasswordLabel)
        self.addSubview(confirmPasswordTextField)
        self.addSubview(line1)
        self.addSubview(line2)
        self.addSubview(continueLabel)
        self.addSubview(continueButton)
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(215)
            make.leading.equalToSuperview().offset(32)
            
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(16)
            make.leading.equalTo(passwordLabel).offset(0)
        }
        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom).offset(32)
            make.leading.equalTo(passwordLabel).offset(0)
        }
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordLabel.snp.bottom).offset(16)
            make.leading.equalTo(passwordLabel).offset(0)
        }
        line1.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(9)
            make.leading.equalTo(passwordLabel).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)

        }
        line2.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(9)
            make.leading.equalTo(passwordLabel).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        continueLabel.snp.makeConstraints { make in
            make.top.equalTo(line2.snp.bottom).offset(67)
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
        }
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(continueLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(329)
            make.height.equalTo(47)
        }
    }
}
