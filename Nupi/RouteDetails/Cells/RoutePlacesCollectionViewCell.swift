//
//  RoutePlacesCollectionViewCell.swift
//  Nupi
//
//  Created by 선가연 on 1/26/25.
//

import UIKit

class RoutePlacesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RoutePlacesCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let placeImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 11
        $0.clipsToBounds = true
    }
    
    let placeNameLabel = UILabel().then {
        $0.font = .body3
        $0.textColor = .icon1
    }
    
    private func setupView() {
        addSubview(placeImageView)
        addSubview(placeNameLabel)
        
        placeImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(159)
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview()
        }
    }
}
