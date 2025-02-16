//
//  BookmarkedStoreCollectionViewCell.swift
//  Nupi
//
//  Created by 선가연 on 2/15/25.
//

import UIKit

class BookmarkedStoreCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookmarkedStoreCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let storeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 7
        $0.clipsToBounds = true
    }
    
    private let saveIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = .saveIcon
    }
    
    let storeNameLabel = UILabel().then {
        $0.textColor = .blue3
        $0.font = UIFont(name: "WantedSans-Medium", size: 16)
    }
    
    let storeLocationIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = .roundPlaceIcon
    }
    
    let storeLocationLabel = UILabel().then {
        $0.textColor = .coffee
        $0.font = UIFont(name: "WantedSans-Medium", size: 13)
    }
    
    private func setupView() {
        // 컴포넌트 추가
        addSubview(storeImageView)
        storeImageView.addSubview(saveIcon)
        addSubview(storeNameLabel)
        addSubview(storeLocationIcon)
        addSubview(storeLocationLabel)
        
        // 레이아웃 설정
        storeImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(125)
        }
        
        saveIcon.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(4)
            $0.width.height.equalTo(30)
        }
        
        storeNameLabel.snp.makeConstraints {
            $0.top.equalTo(storeImageView.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview()
        }
        
        storeLocationIcon.snp.makeConstraints {
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(3.5)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(15)
        }
        
        storeLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(storeLocationIcon)
            $0.leading.equalTo(storeLocationIcon.snp.trailing).offset(3)
            $0.trailing.equalToSuperview()
        }
    }
}
