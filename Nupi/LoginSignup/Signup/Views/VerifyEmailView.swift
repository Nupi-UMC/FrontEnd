//
//  VerifyEmailView.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit
import SnapKit

class VerifyEmailView : UIView {
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var introductionLabel : UILabel = {
        let label = UILabel()
        label.text = "누피와 함께\n하루를 만들어볼까요?"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var verificationCodeTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "nupi@nupi.com"
        textField.font = .systemFont(ofSize: 17)
        textField.textAlignment = .left
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.backgroundColor = UIColor.clear.cgColor
        return textField
    }()
    
    private lazy var divideLine : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var resendVerificationCodeButton : UIButton = {
        let button = UIButton()
        button.setTitle("재발송", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    private lazy var emailVerifyButton : UIButton = {
        let button = UIButton()
        button.setTitle("이메일 인증하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    private func addComponents(){
        self.addSubview(introductionLabel)
        self.addSubview(verificationCodeTextField)
        self.addSubview(resendVerificationCodeButton)
        self.addSubview(emailVerifyButton)
        self.addSubview(divideLine)
        
        introductionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(186)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
        }
        verificationCodeTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(414)
            make.leading.equalToSuperview().offset(32)
            make.width.equalTo(157)
            make.height.equalTo(20)
        }
        resendVerificationCodeButton.snp.makeConstraints{ make in
            make.top.equalTo(verificationCodeTextField.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(32)
            make.width.equalTo(77)
            make.height.equalTo(47)
        }
        emailVerifyButton.snp.makeConstraints { make in
            make.top.equalTo(verificationCodeTextField.snp.bottom).offset(40)
            make.trailing.equalToSuperview().inset(32)
            make.width.equalTo(248)
            make.height.equalTo(47)
        }
        divideLine.snp.makeConstraints { make in
            make.top.equalTo(verificationCodeTextField.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(329)
            make.height.equalTo(1)
        }
    }
}
