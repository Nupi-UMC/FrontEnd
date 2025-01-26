//
//  RouteImageCollectionViewCell.swift
//  Nupi
//
//  Created by 선가연 on 1/26/25.
//

import UIKit

class RouteImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RouteImageCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let routeImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
    }
    
    private let countView = UIView().then {
        $0.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.65)
        $0.layer.cornerRadius = 13
        $0.clipsToBounds = true
        
    }
    
    let countLabel = UILabel().then {
        $0.text = "1/5"
        $0.font = .tabbar1
        $0.textColor = .black
    }
    
    private func setupView() {
        addSubview(routeImageView)
        routeImageView.addSubview(countView)
        countView.addSubview(countLabel)
        
        routeImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(335)
        }
        
        countView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
            $0.width.equalTo(46)
            $0.height.equalTo(27)
        }
        
        countLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
