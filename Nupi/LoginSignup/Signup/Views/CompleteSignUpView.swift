//
//  SignUpCompleteView.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit
import SnapKit

class CompleteSignUpView : UIView {
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.text = "회원가입 완료 🎉"
        return label
    }()
    private lazy var subtitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.text = "누피와 함께 특별한 하루를 만들어 보세요."
        return label
    }()
    private lazy var profilePictureView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 123/2
        imageView.clipsToBounds = true
        imageView.layer.borderColor =  UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var userNicknameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.text = "스눕도기도기독"
        return label
    }()
    private lazy var moveToLoginButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("로그인 화면으로 이동 ->", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    private func addComponents(){
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(profilePictureView)
        self.addSubview(userNicknameLabel)
        self.addSubview(moveToLoginButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(186)
            make.leading.equalToSuperview().offset(35)
        }
        subtitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
        }
        profilePictureView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(106)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(123)
        }
        userNicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profilePictureView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        moveToLoginButton.snp.makeConstraints { make in
            make.top.equalTo(userNicknameLabel.snp.bottom).offset(52)
            make.centerX.equalToSuperview()
            make.height.equalTo(47)
            make.width.equalTo(329)
        }
    }
}
