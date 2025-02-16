//
//  MenuButtonCollectionViewCell.swift
//  Nupi
//
//  Created by 신연주 on 2/15/25.
//

import UIKit
import SnapKit
import Then

class MenuButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuButtonCollectionViewCell"
    
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
        $0.textColor = .icon1
        $0.font = UIFont(name: "WantedSans-Regular", size: 13)
    }
    
    // MARK: 컴포넌트 추가
    private func setupView(){
        addSubview(menuIcon)
        addSubview(menuLabel)
        
        menuIcon.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        menuLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
}
