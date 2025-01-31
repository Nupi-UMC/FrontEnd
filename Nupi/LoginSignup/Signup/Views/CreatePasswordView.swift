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
        self.backgroundColor = .bg
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var circleView1 : UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .blue1
        circleView.layer.cornerRadius = 4
        circleView.clipsToBounds = true
        return circleView
    }()
    
    private lazy var circleView2 : UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .blue2
        circleView.layer.cornerRadius = 6
        circleView.clipsToBounds = true
        return circleView
    }()
    
    private lazy var circleView3 : UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .blue1
        circleView.layer.cornerRadius = 4
        circleView.clipsToBounds = true
        return circleView
    }()
    
    private lazy var passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호 입력"
        label.font = .heading1
        label.textColor = .blue3
        label.textAlignment = .left
        return label
    }()
    
    lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "영문, 숫자 조합",
            attributes: [
                .font: UIFont.body2,
                NSAttributedString.Key.foregroundColor: UIColor.grey2
            ]
        )
        textField.font = .body2
        textField.textColor = .blue3
        textField.textAlignment = .left
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.backgroundColor = UIColor.clear.cgColor
        
        return textField
    }()
    
    private lazy var line1 : UIView = {
        let view = UIView()
        view.backgroundColor = .icon2
        return view
    }()
    
    private lazy var confirmPasswordLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = .heading1
        label.textColor = .blue3
        label.textAlignment = .left

        return label
    }()
    
    lazy var confirmPasswordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "다시 한번 확인해주세요.",
            attributes: [
                .font: UIFont.body2,
                NSAttributedString.Key.foregroundColor: UIColor.grey2
            ]
        )
        textField.font = .body2
        textField.textColor = .blue3
        textField.textAlignment = .left
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.backgroundColor = UIColor.clear.cgColor
        
        return textField
    }()
    
    private lazy var line2 : UIView = {
        let view = UIView()
        view.backgroundColor = .icon2
        return view
    }()
    
    private lazy var continueLabel : UILabel = {
        let label = UILabel()
        label.text = "다음이 마지막 단계에요."
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .blue4
        return label
    }()
    
     lazy var continueButton : UIButton = {
        let button = UIButton()
        button.setTitle("계속하기", for: .normal)
        button.titleLabel?.font = .heading2
        button.setTitleColor(.icon2, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.layer.backgroundColor = UIColor.grey2.cgColor
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    lazy var passwordErrorLabel : UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .rice
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    lazy var confirmPasswordErrorLabel : UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .rice
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    lazy var hidePasswordButton : UIButton = {
        let button = UIButton()
        button.setImage(.eye, for: .normal)
        button.tintColor = .icon2
        button.isHidden = true
        return button
    }()
    
    lazy var hideConfirmPasswordButton : UIButton = {
        let button = UIButton()
        button.setImage(.eye, for: .normal)
        button.tintColor = .icon2
        button.isHidden = true
        return button
    }()
    
    
    private func addComponents(){
        self.addSubview(circleView1)
        self.addSubview(circleView2)
        self.addSubview(circleView3)
        
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(confirmPasswordLabel)
        self.addSubview(confirmPasswordTextField)
        self.addSubview(line1)
        self.addSubview(line2)
        self.addSubview(continueLabel)
        self.addSubview(continueButton)
        
        self.addSubview(passwordErrorLabel)
        self.addSubview(confirmPasswordErrorLabel)
        
        self.addSubview(hidePasswordButton)
        self.addSubview(hideConfirmPasswordButton)
        
        circleView1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(96)
            make.leading.equalToSuperview().offset(321)
            make.width.height.equalTo(8)
        }
        circleView2.snp.makeConstraints { make in
            make.centerY.equalTo(circleView1)
            make.width.height.equalTo(12)
            make.leading.equalTo(circleView1.snp.trailing).offset(8)
        }
        circleView3.snp.makeConstraints { make in
            make.centerY.equalTo(circleView1)
            make.width.height.equalTo(8)
            make.leading.equalTo(circleView2.snp.trailing).offset(8)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(215)
            make.leading.equalToSuperview().offset(32)
            
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(16)
            make.leading.equalTo(passwordLabel).offset(0)
            make.trailing.equalTo(hidePasswordButton.snp.leading)
        }
        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom).offset(32)
            make.leading.equalTo(passwordLabel).offset(0)
        }
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordLabel.snp.bottom).offset(16)
            make.leading.equalTo(passwordLabel).offset(0)
            make.trailing.equalTo(hidePasswordButton.snp.leading)
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
        
        passwordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom).offset(2)
            make.leading.equalTo(line1)
            make.height.equalTo(16)
        }
        confirmPasswordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(line2.snp.bottom).offset(2)
            make.leading.equalTo(line2)
            make.height.equalTo(16)
        }
        
        hidePasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.trailing.equalTo(line1.snp.trailing)
            make.width.height.equalTo(23)
        }
        
        hideConfirmPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(confirmPasswordTextField)
            make.trailing.equalTo(line1.snp.trailing)
            make.width.height.equalTo(23)
        }
    }
}
