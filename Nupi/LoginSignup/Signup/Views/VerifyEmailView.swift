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
    
    lazy var verificationCodeTextField : UITextField = {
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
    
    lazy var timerLabel : UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .blue5
        label.textAlignment = .right
        return label
    }()
    
    lazy var timerButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.trianglehead.clockwise"), for: .normal)
        button.tintColor = .blue5
        return button
    }()
    
    lazy var codeErrorLabel : UILabel = {
        let label = UILabel()
        label.textColor = .rice
        label.font = .caption2
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    lazy var toastPopup : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        label.font = .caption2
        label.textColor = .white
        label.textAlignment = .center
        label.text = "인증번호를 발송했어요."
        label.layer.cornerRadius = 16
        label.clipsToBounds = true
        label.isHidden = true
        return label
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
        
        self.addSubview(timerLabel)
        self.addSubview(timerButton)
        self.addSubview(codeErrorLabel)
        
        self.addSubview(toastPopup)

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
            make.width.equalTo(100)
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
        
        timerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(verificationCodeTextField)
            make.width.equalTo(37)
            make.height.equalTo(16)
            make.trailing.equalTo(divideLine.snp.trailing).inset(14)
        }
        
        timerButton.snp.makeConstraints { make in
            make.centerY.equalTo(verificationCodeTextField)
            make.trailing.equalTo(divideLine.snp.trailing)
            make.width.height.equalTo(12)
        }
        
        toastPopup.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.centerX.equalToSuperview()
            make.width.equalTo(154)
            make.height.equalTo(33)
        }
        
        codeErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(divideLine.snp.bottom).offset(2)
            make.leading.equalTo(divideLine.snp.leading)
            make.height.equalTo(16)
        }
    }
}
