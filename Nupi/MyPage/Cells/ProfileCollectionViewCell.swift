//
//  ProfileCollectionViewCell.swift
//  Nupi
//
//  Created by 신연주 on 2/15/25.
//

import UIKit
import SnapKit
import Then

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Components
    // 프로필 이미지
    let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "steady_popular_spot_image1")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        
        $0.layer.cornerRadius = 40
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.grey2.cgColor
    }
    
    // 닉네임 라벨
    let nicknameLabel = UILabel().then {
        $0.text = "스눕도기독"
        $0.textColor = .blue3
        $0.font = UIFont(name: "WantedSans-Medium", size: 20)
    }
    
    // 이메일 라벨
    let emailLabel = UILabel().then {
        $0.text = "arcticmon..."
        $0.textColor = .icon2
        $0.font = UIFont(name: "WantedSans-Medium", size: 14)
    }
    
    //화살표 이미지
    let vectorIcon = UIImageView().then {
        $0.image = UIImage(named: "vector_icon")
    }
    
    // MARK: 컴포넌트 추가
    private func setupView(){
        addSubview(profileImageView)
        addSubview(nicknameLabel)
        addSubview(emailLabel)
        addSubview(vectorIcon)
        
        profileImageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.height.equalTo(80)
        }
        
        nicknameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalTo(profileImageView.snp.right).offset(14)
        }
        
        emailLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalTo(nicknameLabel.snp.right).offset(6)
        }
        
        vectorIcon.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(3.96)
            $0.width.equalTo(5.52)
            $0.height.equalTo(12.08)
        }
    }
}
