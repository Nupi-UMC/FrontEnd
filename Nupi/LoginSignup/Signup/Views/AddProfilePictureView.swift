//
//  AddProfilePictureView.swift
//  Nupi
//
//  Created by Dana Lim on 1/5/25.
//

import UIKit
import SnapKit

class AddProfilePictureView : UIView {
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var selectProfileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "selectImageIcon")
        
        imageView.layer.cornerRadius = 121/2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nicknameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요. (한글, 영문 사용 가능)"
        textField.font = .systemFont(ofSize: 16)
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.backgroundColor = UIColor.clear.cgColor
        textField.textColor = .lightGray
        return textField
    }()
    
    private lazy var line : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var startButton : UIButton = {
        let button = UIButton()
        button.setTitle("누피 시작하기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    private func addComponents(){
        self.addSubview(selectProfileImageView)
        self.addSubview(nicknameTextField)
        self.addSubview(line)
        self.addSubview(startButton)
        selectProfileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(241)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(121)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(selectProfileImageView.snp.bottom).offset(52)
            make.centerX.equalToSuperview()
            make.width.equalTo(299)
            make.height.equalTo(28)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(9)
            make.height.equalTo(1)
            make.width.equalTo(299)
            make.centerX.equalToSuperview()
        }
        startButton.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(329)
            make.height.equalTo(47)
        }
    }
}
