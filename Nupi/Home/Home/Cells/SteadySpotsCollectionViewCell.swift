//
//  SteadySpotsCollectionViewCell.swift
//  Nupi
//
//  Created by 김건 on 2/20/25.
//

import UIKit

class SteadySpotsCollectionViewCell: UICollectionViewCell {
    static let identifier = "SteadySpotsCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    // 이미지
    let placeImageView = UIImageView().then {
        $0.image = UIImage(named: "steady_popular_spot_image1")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 11
    }
    
    // 장소 이름
    let placeName = UILabel().then {
        $0.font = UIFont(name: "WantedSans-SemiBold", size: 23)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.text = "Gentle Monster house, \nDosan"
    }
    
    // 아이콘 이미지
    let spotIcon = UIImageView().then {
        $0.image = UIImage(named:"spot_icon")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    // 주소
    let placeAddress = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Medium", size: 14)
        $0.textColor = .text1
        $0.text = "강남"
    }
    
    //원 이미지
    let circleImage = UIImageView().then {
        $0.image = UIImage(systemName: "circlebadge.fill")
        $0.tintColor = .blue4
    }
    
    //spot1 역
    let placeStation = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Medium", size: 14)
        $0.textColor = .text1
        $0.text = "압구정로데오역 5번 출구"
    }
    
    //spot1 설명
    let placeDescription = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Medium", size: 15)
        $0.textColor = .icon1
        $0.numberOfLines = 0
        $0.text = "해당 공간에는 젠틀몬스터와 더불어 감각적인 아름다움\n을 지향하는 코스메틱 브랜드 '탬버린즈'와 디저트를 통\n해 새로운 판타지를 구현하는 '누데이크'가 함께 입점했\n습니다."
    }
    
    // MARK: 컴포넌트 추가
    private func setupView(){
        contentView.addSubview(placeImageView)
        contentView.addSubview(placeName)
        contentView.addSubview(spotIcon)
        contentView.addSubview(placeAddress)
        contentView.addSubview(circleImage)
        contentView.addSubview(placeStation)
        contentView.addSubview(placeDescription)
        
        placeImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.width.equalTo(345)
            $0.height.equalTo(265)
        }
        
        placeName.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(12)
            $0.left.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(35)
        }
        spotIcon.snp.makeConstraints {
            $0.top.equalTo(placeName.snp.bottom).offset(11)
            $0.left.equalToSuperview().offset(4)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        placeAddress.snp.makeConstraints {
            $0.top.equalTo(placeName.snp.bottom).offset(12.5)
            $0.left.equalTo(spotIcon.snp.right).offset(6)
        }
        
        circleImage.snp.makeConstraints{
            $0.top.equalTo(placeName.snp.top).offset(19.5)
            $0.left.equalTo(placeAddress.snp.right).offset(7)
            $0.width.equalTo(3)
            $0.height.equalTo(3)
        }
        
        placeStation.snp.makeConstraints {
            $0.top.equalTo(placeName.snp.bottom).offset(12.5)
            $0.left.equalTo(placeAddress.snp.right).offset(13)
        }
        
        placeDescription.snp.makeConstraints {
            $0.top.equalTo(placeAddress.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(4)
            $0.right.equalToSuperview().inset(10)
            $0.width.equalTo(331)
            $0.height.equalTo(72)
        }
    }
}
