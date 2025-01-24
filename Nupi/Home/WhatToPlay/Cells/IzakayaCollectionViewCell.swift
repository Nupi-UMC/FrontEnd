//
//  IzakayaCollectionViewCell.swift
//  Nupi
//
//  Created by 신연주 on 1/24/25.
//

import UIKit

class IzakayaCollectionViewCell: UICollectionViewCell {
    static let identifier = "IzakyaCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Components
    
    // 사진
    let placeImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 13
    }
    
    // 태그
    let tagLabel = UILabel().then{
        $0.text = "AD"
        $0.textColor = .white
        $0.font = UIFont(name: "WantedSans-SemiBold", size: 20)
        $0.textAlignment = .center
        $0.layer.backgroundColor = UIColor.black.cgColor
    }
    
    // 장소 아이콘
    private let placeIcon = UIImageView().then{
        $0.image = UIImage(named: "spot_icon")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    // 장소 이름
    let placeLabel = UILabel().then{
        $0.text = "심 이자카야 강남"
        $0.textColor = .black
        $0.font = UIFont(name: "WantedSans-Medium", size: 22)
    }
    
    // 역
    let stationLabel = UILabel().then{
        $0.text = "강남역 10번 출구"
        $0.textColor = .text1
        $0.font = UIFont(name: "WantedSans-Medium", size: 14)
    }
    
    // 설명
    let descriptionLabel = UILabel().then{
        $0.text = "벚꽃을 옆에두고 한잔 할 수 있는 강남역 유일무이한 분위기 최고의 이자카야입니다. 다양한 사케와 하이볼을 수제 안주들과 즐길 수 있습니다."
        $0.textColor = .icon1
        $0.font = UIFont(name: "WantedSans-SemiBold", size: 15)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    // MARK: 컴포넌트 추가
    private func setupView(){
        addSubview(placeImageView)
        addSubview(tagLabel)
        addSubview(placeLabel)
        addSubview(placeIcon)
        addSubview(stationLabel)
        addSubview(descriptionLabel)
        
        placeImageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalTo(345)
            $0.height.equalTo(290)
        }
        
        tagLabel.snp.makeConstraints{
            $0.top.equalTo(placeImageView.snp.top).offset(26)
            $0.right.equalToSuperview()
            $0.width.equalTo(62)
            $0.height.equalTo(46)
        }
        
        placeLabel.snp.makeConstraints{
            $0.top.equalTo(placeImageView.snp.bottom).offset(18)
            $0.left.equalToSuperview()
            $0.height.equalTo(26)
        }
        
        placeIcon.snp.makeConstraints{
            $0.top.equalTo(placeLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview()
            $0.width.equalTo(13.15)
            $0.height.equalTo(15.2)
        }
        
        stationLabel.snp.makeConstraints{
            $0.top.equalTo(placeIcon.snp.top).offset(0.58)
            $0.left.equalTo(placeIcon.snp.right).offset(6)
            $0.height.equalTo(17)
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(stationLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview()
            $0.height.equalTo(54)
        }
        
    }
}
