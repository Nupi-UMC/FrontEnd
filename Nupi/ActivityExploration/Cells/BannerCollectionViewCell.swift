//
//  BannerCollectionViewCell.swift
//  Nupi
//
//  Created by 선가연 on 1/21/25.
//

import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 배너 이미지 뷰
    let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 9
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // 광고 표시 뷰
    private let adView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue3
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    // 광고 표시 레이블
    private let adLabel: UILabel = {
        let label = UILabel()
        label.text = "AD"
        label.textColor = .bg
        label.font = UIFont(name: "WantedSans-Regular", size: 13)
        return label
    }()
    
    private func setupView() {
        // 서브뷰 추가
        contentView.addSubview(bannerImageView)
        contentView.addSubview(adView)
        adView.addSubview(adLabel)
        
        // 레이아웃 설정
        bannerImageView.snp.makeConstraints {
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
