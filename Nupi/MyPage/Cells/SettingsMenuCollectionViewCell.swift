//
//  SettingMenuCollectionViewCell.swift
//  Nupi
//
//  Created by 김건 on 2/15/25.
//

import UIKit

class SettingsMenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "SettingsMenuCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Components
    // 메뉴 아이콘
    public let menuIcon = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    // 메뉴 라벨
    public let menuLabel = UILabel().then {
        $0.textColor = .text1
        $0.font = UIFont(name: "WantedSans-Regular", size: 18)
    }
    
    // vector 아이콘
    private let vectorIcon = UIImageView().then {
        $0.image = UIImage(named: "vector_icon")
    }
    
    // MARK: 컴포넌트 추가
    private func setupView(){
        addSubview(menuIcon)
        addSubview(menuLabel)
        addSubview(vectorIcon)
        
        menuIcon.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.height.equalTo(23)
        }
        
        menuLabel.snp.makeConstraints{
            $0.left.equalTo(menuIcon.snp.right).offset(12)
            $0.centerY.equalToSuperview()
        }
        
        vectorIcon.snp.makeConstraints{
            $0.right.equalToSuperview().inset(6.03)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(5.25)
            $0.height.equalTo(11.48)
        }
    }
}

