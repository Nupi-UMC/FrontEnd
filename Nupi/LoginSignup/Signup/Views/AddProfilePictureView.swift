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
        circleView.backgroundColor = .blue1
        circleView.layer.cornerRadius = 4
        circleView.clipsToBounds = true
        return circleView
    }()
    
    private lazy var circleView3 : UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .blue2
        circleView.layer.cornerRadius = 6
        circleView.clipsToBounds = true
        return circleView
    }()
    
    lazy var selectProfileImageButton : UIButton = {
        let button = UIButton(type: .custom)
        if let originalImage = UIImage(named: "add_profileimage.png") {
                let resizedImage = resizeImage(image: originalImage, targetSize: CGSize(width: 30, height: 30))
                button.setImage(resizedImage, for: .normal)
        }
            
        button.layer.cornerRadius = 60
        //button.layer.borderWidth = 1
        //button.layer.borderColor = UIColor.grey2.cgColor
        button.backgroundColor = .line1
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
            

        return button
    }()
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            return renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: targetSize))
            }
        }
    
    lazy var nicknameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "닉네임을 입력해주세요. (한글, 영문 사용 가능)",
            attributes: [
                .font: UIFont.body2,
                NSAttributedString.Key.foregroundColor: UIColor.grey2
            ]
        )
        textField.font = .body3
        textField.textColor = .blue3
        textField.textAlignment = .left
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.backgroundColor = UIColor.clear.cgColor
        return textField
    }()
    
    private lazy var line : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var startButton : UIButton = {
        let button = UIButton()
        button.setTitle("누피 시작하기", for: .normal)
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
        
        self.addSubview(selectProfileImageButton)
        self.addSubview(nicknameTextField)
        self.addSubview(line)
        self.addSubview(startButton)
        
        circleView1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(96)
            make.leading.equalToSuperview().offset(321)
            make.width.height.equalTo(8)
        }
        circleView2.snp.makeConstraints { make in
            make.centerY.equalTo(circleView1)
            make.width.height.equalTo(8)
            make.leading.equalTo(circleView1.snp.trailing).offset(8)
        }
        circleView3.snp.makeConstraints { make in
            make.centerY.equalTo(circleView1)
            make.width.height.equalTo(12)
            make.leading.equalTo(circleView2.snp.trailing).offset(8)
        }
        
        selectProfileImageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(241)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(121)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(selectProfileImageButton.snp.bottom).offset(52)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
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
