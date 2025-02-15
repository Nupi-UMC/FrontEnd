//
//  HotIzakayaCollectionViewCell.swift
//  Nupi
//
//  Created by 신연주 on 1/25/25.
//

import UIKit
import Then

class HotIzakayaCollectionViewCell: UICollectionViewCell {
    static let identifier = "HotIzakyaCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Components
    // 이미지
    let placeImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 7
    }
    
    // 태그 아이콘 버튼
    private let tagButton = UIButton().then{
        $0.setImage(UIImage(named: "tag_icon"), for: .normal)
        $0.tintColor = .coffee
        $0.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        $0.layer.cornerRadius = 17
    }
    
    // 장소 이름
    let placeLabel = UILabel().then{
        $0.text = "무제서울"
        $0.textColor = .blue3
        $0.font = UIFont(name: "WantedSans-Medium", size: 16)
    }
    
    // 장소 아이콘
    private let placeIcon = UIImageView().then{
        $0.image = UIImage(named: "spot_icon_blue")
        $0.tintColor = .coffee
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    // 역
    let stationLabel = UILabel().then{
        $0.text = "홍대입구역 1번 출구"
        $0.textColor = .coffee
        $0.font = UIFont(name: "WantedSans-Medium", size: 13)
    }
    
    // MARK: 컴포넌트 추가
    private func setupView(){
        addSubview(placeImageView)
        addSubview(tagButton)
        addSubview(placeLabel)
        addSubview(placeIcon)
        addSubview(stationLabel)
        
        placeImageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.width.equalTo(163)
            $0.height.equalTo(125)
        }
        
        tagButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(91)
            $0.right.equalTo(placeImageView.snp.right).inset(4)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        placeLabel.snp.makeConstraints{
            $0.top.equalTo(placeImageView.snp.bottom).offset(11)
            $0.left.equalToSuperview()
            $0.height.equalTo(19)
        }
        
        placeIcon.snp.makeConstraints{
            $0.top.equalTo(placeLabel.snp.bottom).offset(4.75)
            $0.left.equalToSuperview().offset(2.5)
            $0.width.equalTo(10)
            $0.height.equalTo(12.3)
        }
        
        stationLabel.snp.makeConstraints{
            $0.top.equalTo(placeLabel.snp.bottom).offset(3)
            $0.left.equalTo(placeIcon.snp.right).offset(5.5)
            $0.height.equalTo(16)
        }
    }
}
