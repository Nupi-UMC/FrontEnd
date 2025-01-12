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
        self.backgroundColor = .bg
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var circleView1 : UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .blue2
        circleView.layer.cornerRadius = 6
        circleView.clipsToBounds = true
        return circleView
    }()
    
    private lazy var circleView2 : UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .blue1
        circleView.layer.cornerRadius = 4
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
    
    private lazy var introductionLabel : UILabel = {
        let label = UILabel()
        label.text = "누피와 함께\n특별한 하루를 만들어볼까요?"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = .heading3
        label.textAlignment = .left
        return label
    }()
    
    private lazy var verificationCodeTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "전송된 코드를 입력해주세요.",
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
    
    private lazy var divideLine : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
     lazy var resendVerificationCodeButton : UIButton = {
        let button = UIButton()
        button.setTitle("재발송", for: .normal)
        button.titleLabel?.font = .heading2
        button.setTitleColor(.icon1, for: .normal)
        button.layer.backgroundColor = UIColor.line1.cgColor
        button.layer.cornerRadius = 23.5
        return button
    }()
    
     lazy var emailVerifyButton : UIButton = {
        let button = UIButton()
        button.setTitle("이메일 인증하기", for: .normal)
        button.titleLabel?.font = .heading2
        button.setTitleColor(.icon2, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.layer.backgroundColor = UIColor.grey2.cgColor
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    private func addComponents(){
        self.addSubview(circleView1)
        self.addSubview(circleView2)
        self.addSubview(circleView3)
        
        self.addSubview(introductionLabel)
        self.addSubview(verificationCodeTextField)
        self.addSubview(resendVerificationCodeButton)
        self.addSubview(emailVerifyButton)
        self.addSubview(divideLine)
        
        circleView1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(96)
            make.leading.equalToSuperview().offset(321)
            make.width.height.equalTo(12)
        }
        circleView2.snp.makeConstraints { make in
            make.centerY.equalTo(circleView1)
            make.width.height.equalTo(8)
            make.leading.equalTo(circleView1.snp.trailing).offset(8)
        }
        circleView3.snp.makeConstraints { make in
            make.centerY.equalTo(circleView1)
            make.width.height.equalTo(8)
            make.leading.equalTo(circleView2.snp.trailing).offset(8)
        }
        
        introductionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(186)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
        }
        verificationCodeTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(414)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
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
