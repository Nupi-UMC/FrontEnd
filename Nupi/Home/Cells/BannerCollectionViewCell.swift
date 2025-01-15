//
//  BannerCollectionViewCell.swift
//  Nupi
//
//  Created by 김건 on 1/15/25.
//

import UIKit
import Then

class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BanenrCollextionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    //광고 이미지
    let imageView = UIImageView().then{
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
    }
    
    //설명
    let titleLabel1 = UILabel().then{
        $0.font = UIFont(name: "WantedSans-Regular", size: 18)
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .white
        $0.text = "누피 pick 부천 베이커리 Top 5"
    }
    
    let titleLabel2 = UILabel().then{
        $0.font = UIFont(name: "WantedSans-SemiBold", size: 32)
        $0.textColor = .white
        $0.text = "메리 크리스마스 누피!"
    }
    
    // MARK:컴포넌트 추가
    private func setupView() {
        addSubview(imageView)
        addSubview(titleLabel1)
        addSubview(titleLabel2)
        
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.width.equalTo(393)
            $0.height.equalTo(408)
        }
        
        titleLabel1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(321)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(21)
        }
        titleLabel2.snp.makeConstraints {
            $0.top.equalTo(titleLabel1.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(16)
        }
    }
}
