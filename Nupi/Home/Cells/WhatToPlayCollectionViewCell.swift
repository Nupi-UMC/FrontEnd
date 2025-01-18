//
//  WhatToPlayCollectionViewCell.swift
//  Nupi
//
//  Created by 김건 on 1/15/25.
//

import UIKit
import Then

class WhatToPlayCollectionViewCell: UICollectionViewCell {
    static let identifier = "WhatToPlayCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:
    //버튼
    let placeButton = UIButton().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.setImage(UIImage(named:"izakaya_image"), for: .normal)
        $0.layer.cornerRadius = 11
    }
    
    //장소 이름
    let placeLabel = UILabel().then{
        $0.font = UIFont(name: "WantedSans-Regular", size: 15)
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
        $0.text = "izakaya"
    }
    
    // MARK: 컴포넌트 추가
    private func setupView(){
        addSubview(placeButton)
        addSubview(placeLabel)
        
        placeButton.snp.makeConstraints{
            $0.top.horizontalEdges.equalToSuperview()
            $0.left.horizontalEdges.equalToSuperview()
            $0.width.equalTo(172)
            $0.height.equalTo(186)
        }
        
        placeLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(160)
            $0.left.equalToSuperview().offset(58)
            $0.width.equalTo(56)
            $0.height.equalTo(18)
        }
    }
}
