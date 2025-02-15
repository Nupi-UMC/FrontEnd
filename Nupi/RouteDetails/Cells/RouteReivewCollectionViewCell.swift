//
//  RouteReivewCollectionViewCell.swift
//  Nupi
//
//  Created by 선가연 on 1/26/25.
//

import UIKit

class RouteReivewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RouteReivewCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .line1
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
    }
    
    let profileImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 21
        $0.clipsToBounds = true
    }
    
    let nicknameLabel = UILabel().then {
        $0.font = .tabbar1
        $0.textColor = .blue3
    }
    
    private let menuButton = UIButton().then {
        $0.setImage(.moreVerticalIcon, for: .normal)
    }
    
    let reviewContentLabel = UILabel().then {
        $0.font = .caption2
        $0.textColor = .icon1
        $0.numberOfLines = 5
        $0.textAlignment = .left
    }
    
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(nicknameLabel)
        containerView.addSubview(menuButton)
        containerView.addSubview(reviewContentLabel)
        
        containerView.snp.makeConstraints {
            $0.top.bottom.horizontalEdges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(42)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        menuButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(22)
        }
        
        reviewContentLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalToSuperview().inset(16)
        }
    }
}
