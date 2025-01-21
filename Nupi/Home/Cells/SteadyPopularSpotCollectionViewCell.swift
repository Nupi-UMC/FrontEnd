//
//  SteadyPopularSpotCollectionViewCell.swift
//  Nupi
//
//  Created by 김건 on 1/21/25.
//

import UIKit
import Then

class SteadyPopularSpotCollectionViewCell: UICollectionViewCell {
    static let identifier = "SteadyPopularSpotCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    //spot 이미지
    let spotImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    //spot 이름
    let spotName = UILabel().then {
        $0.font = UIFont(name: "WantedSans-SemiBold", size: 23)
        $0.textColor = .black
        $0.text = "Gentle Monster house,Dosan"
    }
    
    //spot아이콘 이미지
    let spotIcon = UIImageView().then {
        $0.image = UIImage(named:"spot_icon")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    //spot 주소
    let spotAddress = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Regular", size: 14)
        $0.textColor = .text1
        $0.text = "강남"
    }
    
    //원 이미지
    
    //spot 역
    let spotStation = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Regular", size: 14)
        $0.textColor = .text1
        $0.text = "압구정로데오역 5번 출구"
    }
    
    //spot 설명
    let spotDescription = UILabel().then {
        $0.font = UIFont(name: "WantedSans-Regular", size: 15)
        $0.textColor = .icon1
        $0.numberOfLines = 0
        $0.text = "해당 공간에는 젠틀몬스터와 더불어 감각적인 아름다움을 지향하는 코스메틱 브랜드 '탬버린즈'와 디저트를 통해 새로운 판타지를 구현하는 '누데이크'가 함께 입점했습니다."
    }
    
    // MARK: 컴포넌트 배치
    private func setupView(){
        addSubview(spotImageView)
        addSubview(spotName)
        addSubview(spotIcon)
        addSubview(spotAddress)
        addSubview(spotStation)
        addSubview(spotDescription)
        
        spotImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalTo(345)
            $0.height.equalTo(265)
        }
        
        spotName.snp.makeConstraints {
            $0.top.equalTo(spotImageView.snp.bottom).offset(12)
            $0.left.equalToSuperview()
            $0.width.equalTo(257)
            $0.height.equalTo(62)
        }
        spotIcon.snp.makeConstraints {
            $0.top.equalTo(spotName.snp.bottom).offset(11)
            $0.left.equalToSuperview()
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        spotAddress.snp.makeConstraints {
            $0.top.equalTo(spotName.snp.bottom).offset(12.5)
            $0.left.equalTo(spotIcon.snp.right).offset(6)
        }
        
        spotStation.snp.makeConstraints {
            $0.top.equalTo(spotName.snp.bottom).offset(12.5)
            $0.left.equalTo(spotAddress.snp.right).offset(13)
        }
        
        spotDescription.snp.makeConstraints {
            $0.top.equalTo(spotAddress.snp.bottom).offset(8)
            $0.left.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
}
