//
//  BannerCollectionViewCell.swift
//  Nupi
//
//  Created by 선가연 on 1/21/25.
//

import UIKit
import SnapKit
import Then

class AdBannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "AdBannerCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 배너 이미지 뷰
    let bannerImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
    }
    
    // 광고 표시 뷰
    private let adView = UIView().then {
        $0.backgroundColor = .blue3
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    // 광고 표시 레이블
    private let adLabel = UILabel().then {
        $0.text = "AD"
        $0.textColor = .bg
        $0.font = UIFont(name: "WantedSans-Regular", size: 13)
    }
    
    private func setupView() {
        // 컴포넌트 추가
        addSubview(bannerImageView)
        addSubview(adView)
        adView.addSubview(adLabel)
        
        // 레이아웃 설정
        bannerImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.width.equalTo(337)
            $0.height.equalTo(115)
        }
        
        adView.snp.makeConstraints {
            $0.top.equalTo(bannerImageView.snp.top).offset(8)
            $0.trailing.equalTo(bannerImageView.snp.trailing).offset(-8)
            $0.width.equalTo(30)
            $0.height.equalTo(15)
        }
        
        adLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
