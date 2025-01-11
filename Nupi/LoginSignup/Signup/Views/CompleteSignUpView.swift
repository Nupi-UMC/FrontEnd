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
        self.backgroundColor = .bg
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
    
        let symbolImage = UIImage(systemName: "xmark")
        button.setImage(symbolImage, for: .normal)
        button.tintColor = .icon1
        return button
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .blue3
        label.font = .heading3
        label.textAlignment = .left
        label.text = "회원가입 완료 🎉"
        return label
    }()
    private lazy var subtitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .icon2
        label.font = .body3
        label.textAlignment = .left
        label.text = "누피와 함께 특별한 하루를 만들어 보세요."
        return label
    }()
    private lazy var profilePictureView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 123/2
        imageView.clipsToBounds = true
        imageView.layer.borderColor =  UIColor.grey2.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var userNicknameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .blue3
        label.font = .heading1
        label.textAlignment = .center
        label.text = "스눕도기도기독"
        return label
    }()
    private lazy var moveToLoginPageButton : UIButton = {
        let button = UIButton()
        button.setTitle("로그인 화면으로 이동", for: .normal)
        button.titleLabel?.font = .heading2
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue3
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 19, weight: .light)
        let arrow = UIImage(systemName: "arrow.right", withConfiguration: configuration)
        button.setImage(arrow, for: .normal)
        
        button.tintColor = .white
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -5) // 텍스트와 이미지 간격 설정
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    private func addComponents(){
        self.addSubview(exitButton)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(profilePictureView)
        self.addSubview(userNicknameLabel)
        self.addSubview(moveToLoginPageButton)
        
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(66)
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(30)
        }
        
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
        moveToLoginPageButton.snp.makeConstraints { make in
            make.top.equalTo(userNicknameLabel.snp.bottom).offset(52)
            make.centerX.equalToSuperview()
            make.height.equalTo(47)
            make.width.equalTo(329)
        }
    }
}
