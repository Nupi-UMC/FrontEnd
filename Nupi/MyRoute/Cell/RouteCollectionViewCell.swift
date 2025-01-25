//
//  RouteCollectionViewCell.swift
//  Nupi
//
//  Created by 선가연 on 1/23/25.
//

import UIKit

class RouteCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RouteCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let routeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 7
        $0.clipsToBounds = true
    }
    
    private let photoIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = .photoMultipleIcon
    }
    
    let routeNameLabel = UILabel().then {
        $0.textColor = .blue3
        $0.font = UIFont(name: "WantedSans-Medium", size: 16)
    }
    
    let routeLocationIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = .roundPlaceIcon
    }
    
    let routeLocationLabel = UILabel().then {
        $0.textColor = .coffee
        $0.font = UIFont(name: "WantedSans-Medium", size: 13)
    }
    
    private func setupView() {
        // 컴포넌트 추가
        addSubview(routeImageView)
        routeImageView.addSubview(photoIcon)
        addSubview(routeNameLabel)
        addSubview(routeLocationIcon)
        addSubview(routeLocationLabel)
        
        // 레이아웃 설정
        routeImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(125)
        }
        
        photoIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.width.height.equalTo(24)
        }
        
        routeNameLabel.snp.makeConstraints {
            $0.top.equalTo(routeImageView.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview()
        }
        
        routeLocationIcon.snp.makeConstraints {
            $0.top.equalTo(routeNameLabel.snp.bottom).offset(3.5)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(15)
        }
        
        routeLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(routeLocationIcon)
            $0.leading.equalTo(routeLocationIcon.snp.trailing).offset(3)
            $0.trailing.equalToSuperview()
        }
    }
}
